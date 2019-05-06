<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Auth::routes();

Route::get('/clientes/index', 'clientes@index');
Route::patch('/clientes/store', 'clientes@store');
Route::post('/clientes/update/{id}', 'clientes@update');
Route::get('/clientes/destroyAll', 'clientes@destroyAll');

Route::get('/produtos/index', 'produtos@index');
Route::patch('/produtos/store', 'produtos@store');
Route::post('/produtos/update/{id}', 'produtos@update');
Route::get('/produtos/destroyAll', 'produtos@destroyAll');


Route::get('/pedidos/index', 'pedidos@index');
Route::patch('/pedidos/store', 'pedidos@store');
Route::patch('/pedidos/storeProd', 'pedidos@storeProd');
Route::post('/pedidos/update/{id}', 'pedidos@update');
Route::post('/pedidos/updatedesconto/{id}', 'pedidos@updatedesconto');
Route::post('/pedidos/updatestatus/{id}', 'pedidos@updatestatus');
Route::get('/pedidos/destroyAll', 'pedidos@destroyAll');
Route::get('/pedidos/buscaCliente', 'pedidos@buscaCliente');
Route::get('/pedidos/buscaProduto', 'pedidos@buscaProduto');


Route::get('/pedidositens/index', 'pedidositens@index');
Route::patch('/pedidositens/store', 'pedidositens@store');
Route::post('/pedidositens/update/{id}', 'pedidositens@update');
Route::get('/pedidositens/destroyAll', 'pedidositens@destroyAll');
Route::get('/pedidositens/buscaCliente', 'pedidositens@buscaCliente');




Route::get('/{vue_capture?}', function () {
    return view('index');
})->where('vue_capture', '[\/\w\.-]*');



Route::get('password/reset/{token}', function () {
    return view('index');
})->name('password.reset');
