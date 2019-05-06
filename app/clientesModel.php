<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class clientesModel extends Model
{
    protected $fillable = ['nome','cpf','email'];
    protected $primaryKey = 'id';
    protected $guarded = ['id', 'created', 'updated','modified'];
    protected $table = 'clientes';

    const CREATED_AT = 'created';
    const UPDATED_AT = 'modified';
}
