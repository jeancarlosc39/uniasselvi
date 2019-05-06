<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class produtosModel extends Model
{
    protected $fillable = ['nome','codbarras','valor'];
    protected $primaryKey = 'id';
    protected $guarded = ['id', 'created', 'updated','modified'];
    protected $table = 'produtos';

    const CREATED_AT = 'created';
    const UPDATED_AT = 'modified';
}
