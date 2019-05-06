<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Pedidos extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pedidos', function (Blueprint $table) {

                if(!Schema::hasTable('pedidos')) {

                    $table->increments('id');
                    $table->unsignedInteger('cliente_id');
                    $table->foreign('cliente_id')->references('id')->on('cliente');
                    $table->string('status');
                    $table->date('dtpedido');
                    $table->decimal('valortotal',13,2);
                    $table->integer('desconto')->default(0);
                    $table->decimal('valordesconto',13,2);
                    $table->dateTime('modified');
                    $table->dateTime('created');
                    $table->dateTime('updated');

                    //  $table->timestamps();
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
        Schema::dropIfExists('pedido');
    }

}
