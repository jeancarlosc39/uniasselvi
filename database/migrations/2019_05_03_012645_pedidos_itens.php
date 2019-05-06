<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Pedidositens extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pedidos_itens', function (Blueprint $table) {
            if(!Schema::hasTable('pedidos_itens')) {
                 $table->increments('id');
                 $table->unsignedInteger('pedido_id');
                 $table->foreign('pedido_id')->references('id')->on('pedidos')->onDelete('cascade');
                 $table->unsignedInteger('produto_id');
                 $table->foreign('produto_id')->references('id')->on('produtos');
                 $table->integer('qtde')->default(0);
                 $table->dateTime('modified');
                 $table->dateTime('created');
                 $table->dateTime('updated');
            }
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
