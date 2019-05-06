<?php

namespace App\Http\Controllers;
use App\clientesModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class clientes extends Controller
{
    public function index(Request $request){

        $id = request('id');
        $sortBy = request('sortBy');
        $desc = request('descending');
        $perPage = request('rowsPerPage');

        if(isset($sortBy)){
            $sortBy =  $sortBy ;
            if($desc == 'true') {
                $ordem = 'asc';
            }else{
                $ordem = 'desc';
            }
            $items =DB::table('clientes')
                ->orderBy( $sortBy, $ordem)
                ->paginate(    $perPage);
        }else{
            $items =DB::table('clientes')
                ->orderBy( 'modified', 'desc')
                ->paginate(    $perPage);
        }
        $response = [
            'pagination' => [
                'total' => $items->total(),
                'per_page' => $items->perPage(),

                'current_page' => $items->currentPage(),
                'last_page' => $items->lastPage(),
                'from' => $items->firstItem(),
                'to' => $items->lastItem()
            ],
            'data' => $items
        ];
        return response()->json($response );
    }

    public function update(Request $request, $id)
    {
        $item = clientesModel::find($id);

        $item->nome= request('nome');
        $item->cpf =  request('cpf');
        $item->email =  request('email');
        $item->save();
        return response()->json(true);

    }

    public function store(Request $request)
    {
        $flag = true;

        $user =  clientesModel::where('email', '=',  request('email'))->get();
        if(count($user) != 0){
            return response()->json('email');
            $flag = false;
            exit();
        }
        $user =  clientesModel::where('cpf', '=',  request('cpf'))->get();
        if(count($user) != 0){
            return response()->json('cpf');
            $flag = false;
            exit();
        }
        if( $flag == true){
            $item = new clientesModel([
                'nome'=> request('nome'),
                'cpf' =>  request('cpf'),
                'email' =>  request('email')
            ]);
            $item->save();
            return response()->json("sucesso");
        }

    }

    public function destroy($id)
    {

        $usuario= clientesModel::findOrFail($id);
        $usuario->delete();
        return response()->json('Excluido com Sucesso');
    }
    public function destroyAll(Request $request)
    {
        $arrTemp = array();
        foreach ($request->id as $row){
            $stdClass = json_decode( $row);
            $arrTemp[] = $stdClass->id;
        }
        try {
            DB::table("clientes")->whereIn('id', $arrTemp)->delete();
            return response()->json(  $request->id);
        }
        catch (\Exception $e) {
            return $e->getMessage();
        }
    }
}
