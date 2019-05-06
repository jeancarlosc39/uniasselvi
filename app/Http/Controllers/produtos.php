<?php

namespace App\Http\Controllers;
use App\produtosModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class produtos extends Controller
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
            $items =DB::table('produtos')
                ->orderBy( $sortBy, $ordem)
                ->paginate(    $perPage);
        }else{
            $items =DB::table('produtos')
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
        $item = produtosModel::find($id);

        $item->nome= request('nome');
        $item->codbarras =  request('codbarras');
        $item->valor =  str_replace(',', '.',str_replace('.', '',request('valor')));
        $item->save();
        return response()->json(true);

    }

    public function store(Request $request)
    {
        $flag = true;

        $user =  produtosModel::where('nome', '=',  request('nome'))->get();
        if(count($user) != 0){
            return response()->json('nome');
            $flag = false;
            exit();
        }

        if( $flag == true){
            $item = new produtosModel([
                'nome'=> request('nome'),
                'codbarras' =>  request('codbarras'),
                //'valor' =>  request('valor')
                'valor' =>str_replace(',', '.',str_replace('.', '',request('valor')))
            ]);
            $item->save();
            return response()->json("sucesso");
        }

    }

    public function destroy($id)
    {

        $usuario= produtosModel::findOrFail($id);
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
            DB::table("produtos")->whereIn('id', $arrTemp)->delete();
            return response()->json(  $request->id);
        }
        catch (\Exception $e) {
            return $e->getMessage();
        }
    }
}
