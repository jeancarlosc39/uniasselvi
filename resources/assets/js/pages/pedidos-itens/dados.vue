<template>
    <div>
        <v-alert v-if="!showmensagem" dismissible v-model="alert" :type="tipo" :value="true">
            {{ mensagem }}
        </v-alert>
        <v-dialog v-model="dialog" max-width="500px">

            <v-btn color="primary"  to="/pedidos/dados" dark slot="activator" class="mb-2">Voltar</v-btn>

            <v-btn color="primary" @click.native="btnInserir()" dark slot="activator" class="mb-2">Novos</v-btn>
            <v-card>
                <v-card-title>
                    <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-form v-model="valid"  ref="form" lazy-validation>

                    <v-card-text>
                        <v-container grid-list-md>
                            <v-layout wrap>

                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-model="pedidos.pedido_id"
                                            label="Numero Pedido"
                                            disabled

                                    ></v-text-field>
                                </v-flex>

                                <v-flex xs12 sm6 md4>
                                    <v-select
                                            v-bind:items="listaProduto"
                                            single-line
                                            item-text="produto"
                                            item-value="id"
                                            label="Produtos"
                                            v-model="pedidos.produto_id"
                                            :rules="[v => !!v || 'Campo Requerido']"
                                            required
                                    ></v-select>

                                </v-flex>
                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-model="pedidos.qtde"
                                            label="Qtde"
                                            :counter="10"
                                            mask="###"
                                            required
                                    ></v-text-field>
                                </v-flex>
                                <v-spacer></v-spacer>

                            </v-layout>
                        </v-container>
                    </v-card-text>

                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="blue darken-1" flat @click.native="close">Cancelar</v-btn>
                        <v-btn color="blue darken-1" flat @click.native="save">Salvar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>

        </v-dialog>
        <v-dialog  v-if="!show" v-model="dialogExcluir" persistent max-width="290">
            <v-btn v-if="!show"  dark slot="activator" color="primary" >Excluir Selecionados</v-btn>
            <v-card>
                <v-card-title class="headline">Deseja excluir todos os itens?</v-card-title>

                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn color="primary" flat @click.native="dialogExcluir = false">Não</v-btn>
                    <v-btn color="primary" flat @click.native="deleteAll()">Sim</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-card>

            <v-data-table
                    v-model="selected"
                    v-bind:headers="headers"
                    v-bind:items="items"
                    select-all
                    @click.native="toggleAll()"
                    item-key="id"
                    rows-per-page-text=" Itens por pagina"
                    :rows-per-page-items=[20]
                    :pagination.sync="pagination"
                    :total-items="totalItems"
                    :loading="loading"
                    class="elevation-1"  >
                <template slot="header" slot-scope="props">
                    <v-tooltip bottom>
                        <span slot="activator">
                          {{ props.header.text }}
                        </span>
                        <span>
                          {{ props.header.text }}
                        </span>
                    </v-tooltip>
                </template>
                <template slot="items" slot-scope="props">
                    <td>
                        <v-checkbox
                                primary
                                hide-details
                                @change="onCheckboxChange(props.item,$event)"
                                :input-value="props.item"
                                v-model="props.selected"
                        ></v-checkbox>
                    </td>

                    <td class="text-xs-center body-1">{{ props.item.produto_id}}</td>
                    <td class="text-xs-center body-1">{{ props.item.produto}}</td>
                    <td class="text-xs-center body-1">{{ props.item.qtde}}</td>

                    <td class="justify-center layout px-0">
                        <v-btn icon class="mx-0" @click="editItem(props.item)">
                            <v-icon color="teal">add</v-icon>
                        </v-btn>
                    </td>
                </template>

                <template slot="pageText" slot-scope="item">
                    {{item.pageStart}} - {{item.pageStop}}, total {{item.itemsLength}}
                </template>
                <template slot="no-data">
                    <v-btn color="primary" @click="getDataFromApi">Reset</v-btn>
                </template>

            </v-data-table>
        </v-card>
    </div>
</template>
<script>
    var urlParams = new URLSearchParams(window.location.search);

   // var npedido = console.log(urlParams.getAll('pedido'));
    var npedido = urlParams.getAll('pedido');
    export default {

        data: function () {
            return {
                npedido:npedido,
                valid: true,
                dialogExcluir: false,
                disabledEmail:true,
                showmensagem:true,
                selected: [],
                listaProduto:[],
                alert: true,
                mensagem:'',
                totalItems: 0,
                pagination: {
                    rowsPerPage: 20
                },
                loading: false,
                checkValue:[],
                checkbox:[],
                show: true,
                options: [],
                dialog: false,
                headers: [

                    {text: 'produto_id',value: 'produto_id' },
                    {text: 'produto', value: 'produto'},
                    {text: 'qtde', value: 'qtde'},
                    {text: 'Ação', value: 'id'}
                ],
                items: [],
                editedIndex: -1,
                rulesNome: [
                    v => !!v || 'Nome é requerido!',
                    v => (v && v.length <= 100) || 'Campo não pode ser maior que 100 caracteres!'
                ],
                pedidos: {
                    value: false,
                    cliente: '',
                    cpf:'',
                    pedido:'',
                    produto: '',
                    produto_id:'',
                    pedido_id: '',
                    qtde: '',
                    id: ''

                },
                defaultItem: {
                    value: false,
                    cliente: '',
                    cpf:'',
                    pedido: '',
                    produto: '',
                    produto_id:'',
                    pedido_id: '',
                    qtde: '',
                    id: ''
                }
                ,
                select: { id: '0', nome: 'Selecione' },
                listaProduto: [ ],

            }
        },
        computed: {
            formTitle () {
                return this.editedIndex === -1 ? 'Novo Item' : 'Editar Item'
            }
        },
        watch: {
            dialog (val) {
                val || this.close()
            },
            pagination:{
                handler(){
                    this.getDataFromApi()
                },
                deep: true
            },
        },
        mounted () {
            this.buscaProduto()
            this.getDataFromApi()

        },

        methods: {
            removeByKey(array, params){
                array.some(function(item, index) {
                    return (array[index][params.key] === params.value) ? !!(array.splice(index, 1)) : false;
                });
                return array;
            },
            onCheckboxChange(item, acao) {
                if (acao == true) {
                    this.checkValue.push({"id":item.id} )
                    this.show = false;
                } else {
                    var removed = this.removeByKey(this.checkValue, {
                        key: 'id',
                        value: item.id
                    });
                    this.show = true;
                }
            },

            toggleAll:function (){
                var check = []
                if (this.selected.length)
                {
                    this.selected.forEach(function(selected){
                        check.push({id:selected.id})
                    })
                    this.show = false;
                }else{
                    this.show = true;
                    this.selected.forEach(function(selected){
                        var removed = this.removeByKey(check, {
                            key: 'id',
                            value: selected.id
                        });
                        this.show = true;
                    })
                }
                this.checkValue = check
            },
            buscaProduto: function(){
                axios.get('/pedidos/buscaProduto').then((res) => {
                    this.listaProduto= res.data;
                });
            },

            getDataFromApi: function () {
                var urlParams = new URLSearchParams(window.location.search);

                // var npedido = console.log(urlParams.getAll('pedido'));
                var npedido = urlParams.getAll('pedido');

                this.loading = true;
                return new Promise((resolve, reject) => {
                    const {sortBy,pedido, descending, page, rowsPerPage} = this.pagination;
                    let config = {
                        params: {
                            pedido:npedido,
                            sortBy:sortBy,
                            descending:descending,
                            page: page,
                            rowsPerPage: rowsPerPage
                        },
                    }
                    axios.get('/pedidositens/index', config)
                        .then((res) => {
                            this.items = res.data.data.data;
                            console.log( res.data.data);
                            let items = res.data.data.data;
                            const total = res.data.data.total
                            this.loading = false;
                            this.totalItems = res.data.data.total
                            resolve({
                                items,
                                total
                            });

                            if (rowsPerPage > 0) {
                                items = items.slice((page - 1) * rowsPerPage, page * rowsPerPage)
                            }
                            setTimeout(() => {
                                this.loading = false
                                resolve({
                                    items,
                                    total
                                })
                            }, 1000)

                        }).catch(function (error) {
                        console.log(error);
                    });
                })
            },
            editItem (item) {
                this.editedIndex = this.items.indexOf(item)
                this.pedidos= Object.assign({}, item)

                this.dialog = true
            },
            btnInserir(){

                this.pedidos.pedido_id = npedido.toString();
            },
            deleteAll(){
                let config = {
                    params: {
                        id: this.checkValue

                    },
                }
                axios.get('/pedidositens/destroyAll', config).then((res) => {
                    console.log(res.data);
                    this.dialogExcluir = false
                    this.getDataFromApi()
                    this.show = true
                }).catch(function (error) {
                    console.log(error);
                });
            },
            insert () {
                if (this.$refs.form.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido= app.pedidos;
                    axios.patch('/pedidositens/store',  novoPedido)
                        .then( ( resp ) => {
                            console.log(resp.data)

                                this.mensagem = 'Adicionado com Sucesso!'
                                this.showmensagem = false;
                                this.tipo = "success"
                                this.close ()
                                this.getDataFromApi()

                        })
                        .catch(function (resp) {
                            console.log(resp.data)
                        });
                }
            },
            update () {
                if (this.$refs.form.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido = app.pedidos;
                    let uri = '/pedidositens/update/'+app.pedidos.id;
                    axios.post(uri, novoPedido).then((resp) => {
                        this.mensagem = 'Adicionado com Sucesso!'
                        this.showmensagem = false;
                        this.tipo = "success"
                        this.close ()
                        this.getDataFromApi()
                        console.log(resp.data)
                    }).catch(function (resp) {
                        console.log(resp.data);

                    });
                }
            },
            close () {
                this.dialog = false
                setTimeout(() => {
                    this.pedidos = Object.assign({}, this.defaultItem)
                    this.editedIndex = -1
                }, 300)
            },
            save () {
                if (this.editedIndex > -1) {
                    Object.assign(this.items[this.editedIndex], this.pedidos)
                    this.update()
                } else {
                    this.insert()
                }
            }
        }
    }
</script>



