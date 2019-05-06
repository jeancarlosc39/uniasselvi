<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class pedidosItensModel extends Model
{
    protected $fillable = ['produto_id','pedido_id','qtde'];
    protected $primaryKey = 'id';
    protected $guarded = ['id','created', 'updated','modified'];
    protected $table = 'pedidos_itens';

    const CREATED_AT = 'created';
    const UPDATED_AT = 'modified';
}
