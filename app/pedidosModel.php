<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class pedidosModel extends Model
{
    protected $fillable = ['cliente_id','status','dtpedido','valortotal','desconto','valordesconto'];
    protected $primaryKey = 'id';
    protected $guarded = ['id','cliente_id', 'created', 'updated','modified'];
    protected $table = 'pedidos';

    const CREATED_AT = 'created';
    const UPDATED_AT = 'modified';
}
