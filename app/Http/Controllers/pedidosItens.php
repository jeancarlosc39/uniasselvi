<?php

namespace App\Http\Controllers;
use App\pedidosItensModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class pedidosItens extends Controller
{
    public function index(Request $request){


        $id = request('id');
        $sortBy = request('sortBy');
        $desc = request('descending');
        $perPage = request('rowsPerPage');
        $pedidoId = request('pedido');
        if(isset($sortBy)){
            $sortBy =  $sortBy ;
            if($desc == 'true') {
                $ordem = 'asc';
            }else{
                $ordem = 'desc';
            }
            $items =DB::table('detalhe_itens')

                ->where('pedido', '=',$pedidoId)
                ->orderBy( $sortBy, $ordem)
                ->paginate(    $perPage);
        }else{
            $items =DB::table('pedidos')

             //   ->join('clientes', 'pedidos.cliente_id', '=', 'clientes.id')
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
        $item =pedidosItensModel::find($id);
        $item->produto_id =  request('produto_id');
        $item->qtde =  request('qtde');
        $item->save();
        return response()->json(true);

    }

    public function store(Request $request)
    {
        $flag = true;
        if( $flag == true){
            $item = new pedidosItensModel([
                'produto_id'=> request('produto_id'),
                'qtde' =>  request('qtde'),
                'pedido_id' =>  request('pedido_id'),

            ]);
            $item->save();
            return response()->json("sucesso");
        }

    }

    public function destroy($id)
    {

        $usuario= pedidosModel::findOrFail($id);
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
            DB::table("pedidos")->whereIn('id', $arrTemp)->delete();
            return response()->json(  $request->id);
        }
        catch (\Exception $e) {
            return $e->getMessage();
        }
    }
    public function buscaCliente()
    {
        $row = DB::table('clientes')
            ->orderBy( 'nome', 'asc')
            ->get();
        return $row ;
    }
}
