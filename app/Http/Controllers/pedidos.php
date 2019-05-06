<?php

namespace App\Http\Controllers;
use App\pedidosItensModel;
use App\pedidosModel;
use App\produtosModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class pedidos extends Controller
{
    public function index(Request $request){

        $id = request('id');
        $sortBy = request('sortBy');
        $status = request('status');
        $desc = request('descending');
        $perPage = request('rowsPerPage');

        if(isset($sortBy)){
        $sortBy =  $sortBy ;
        if($desc == 'true') {
            $ordem = 'asc';
        }else{
            $ordem = 'desc';
        }
        if(isset( $status)){
            $status=$status;
        }else{
            $status = [''];
        }
        $items =DB::table('view_pedidos')
            ->where('status', '=',$status)
            ->orderBy( $sortBy, $ordem)
            ->paginate(    $perPage);
        }else{
            $items =DB::table('view_pedidos')
                ->where('status', '=',$status)

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


    public function updateDesconto(Request $request, $id)
    {
        $item = pedidosModel::find($id);
        $item->desconto =  request('desconto');
        $item->save();
        return response()->json(true);

    }

    public function updateStatus(Request $request, $id)
    {
        $item = pedidosModel::find($id);
        $item->status =  request('status');
        $item->save();
        return response()->json(true);

    }

    public function store(Request $request)
    {

        $data = substr(request('dtpedido'), -4) . substr(request('dtpedido'),2, -4) . substr(request('dtpedido'),0, -6);
        $flag = true;
        if( $flag == true){
            $item = new pedidosModel([
                'cliente_id'=> request('cliente_id'),
                'status' =>  request('status'),
                'dtpedido' =>  $data,
                'desconto' =>   0

            ]);
            $item->save();
            return response()->json("sucesso");
        }
    }
    public function storeProd(Request $request)
    {
        $flag = true;
        if( $flag == true){
            $item = new pedidosItensModel([
                'produto_id'=> request('produto_id'),
                'qtde' =>  request('qtde'),
                'pedido_id' =>  request('id'),

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
    public function buscaProduto()
    {
        $row = DB::table('produtos')
           ->select("produtos.*"
               ,DB::raw("CONCAT(produtos.nome,'  - R$: ',produtos.valor) as produto"))
            ->orderBy( 'nome', 'asc')
            ->get();
        return $row ;
    }
}
