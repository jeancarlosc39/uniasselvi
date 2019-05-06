
<template>

    <div>
        <v-alert v-if="!showmensagem" dismissible v-model="alert" :type="tipo" :value="true">
            {{ mensagem }}
        </v-alert>
        <v-dialog v-model="dialog" max-width="500px">
            <v-btn color="primary"  dark slot="activator" class="mb-2">Novos</v-btn>
            <v-card>
                <v-card-title>
                    <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-form v-model="valid"  ref="formPed" lazy-validation>

                    <v-card-text>
                        <v-container grid-list-md>
                            <v-layout wrap>
                                <v-flex xs12 sm6 md4>
                                    <v-select
                                            single-line
                                            item-text="nome"
                                            item-value="id"
                                            label="Status Pedido"
                                            v-bind:items="listaStatus"
                                            v-model="pedidos.status"
                                            :rules="[v => !!v || 'Campo Requerido']"
                                            required
                                    >
                                    </v-select>
                                </v-flex>
                                <v-flex xs12 sm6 md4>
                                    <v-select
                                            v-bind:items="listaCliente"
                                            single-line
                                            item-text="nome"
                                            item-value="id"
                                            label="Cliente"
                                            v-model="pedidos.cliente_id"
                                            :rules="[v => !!v || 'Campo Requerido']"
                                            required
                                    ></v-select>

                                </v-flex>
                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-model="pedidos.dtpedido"
                                            label="Data do Pedido"
                                            mask="##/##/####"
                                            required
                                    ></v-text-field>
                                </v-flex>


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

        <v-dialog v-model="dialogProd" max-width="500px">
            <v-card>
                <v-card-title>
                    <span class="headline">{{ formTitle }}</span>
                </v-card-title>
                <v-form v-model="valid"  ref="formPedProd" lazy-validation>

                    <v-card-text>
                        <v-container grid-list-md>
                            <v-layout wrap>

                                    <v-flex xs12 sm6 md4>
                                        <v-text-field
                                                v-model="pedidos.id"
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
                        <v-btn color="blue darken-1" flat @click.native="closeProd">Cancelar</v-btn>
                        <v-btn color="blue darken-1" flat @click.native="saveprod">Salvar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>
        <v-dialog v-model="dialogDesconto" max-width="500px">

            <v-card>
                <v-card-title>
                    <span class="headline">Adicionar Desconto</span>
                </v-card-title>
                <v-form v-model="valid"  ref="formDesconto" lazy-validation>

                    <v-card-text>
                        <v-container grid-list-md>
                            <v-layout wrap>
                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-model="pedidos.id"
                                            label="Numero Pedido"
                                            disabled

                                    ></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-model="pedidos.desconto"
                                            mask="##"
                                            label="Desconto"
                                    ></v-text-field>
                                </v-flex>
                            </v-layout>
                        </v-container>
                    </v-card-text>

                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="blue darken-1" flat @click.native="closeDesconto">Cancelar</v-btn>
                        <v-btn color="blue darken-1" flat @click.native="savedesconto">Salvar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>
        <v-dialog v-model="dialogStatus" max-width="500px">

            <v-card>
                <v-card-title>
                    <span class="headline">Alterar Status</span>
                </v-card-title>
                <v-form v-model="valid"  ref="formStatus" lazy-validation>

                    <v-card-text>
                        <v-container grid-list-md>
                            <v-layout wrap>
                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-model="pedidos.id"
                                            label="Numero Pedido"
                                            disabled

                                    ></v-text-field>
                                </v-flex>
                                <v-flex xs12 sm6 md4>
                                    <v-select
                                            single-line
                                            item-text="nome"
                                            item-value="id"
                                            label="Status Pedido"
                                            v-bind:items="listaStatus"
                                            v-model="pedidos.status"
                                            :rules="[v => !!v || 'Campo Requerido']"
                                            required
                                    >
                                    </v-select>
                                </v-flex>

                            </v-layout>
                        </v-container>
                    </v-card-text>

                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <v-btn color="blue darken-1" flat @click.native="closeStatus">Cancelar</v-btn>
                        <v-btn color="blue darken-1" flat @click.native="saveStatus">Salvar</v-btn>
                    </v-card-actions>
                </v-form>
            </v-card>
        </v-dialog>
        <v-card>
                <v-card-title>
                    <v-layout wrap>
                        <v-flex xs6 sm6 md4>
                            <v-select
                                    single-line
                                    item-text="nome"
                                    item-value="id"
                                    label="Status Pedido"
                                    @change="changeStatus"
                                    v-bind:items="listaStatus"
                                    hint="selecione o Status"
                            >
                            </v-select>
                        </v-flex>

                    </v-layout>
                </v-card-title>
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
                    <td >
                        <v-checkbox
                                primary
                                hide-details
                                @change="onCheckboxChange(props.item,$event)"
                                :input-value="props.item"
                                v-model="props.selected"
                        ></v-checkbox>
                    </td>
                    <td class="text-xs-right body-1">{{ props.item.id}}</td>
                    <td class="text-xs-right body-1">{{ props.item.nome}}</td>
                    <td class="text-xs-right body-1">
                        <v-btn  @click="openDialogStatus(props.item)" icon class="mx-0">
                        <v-icon color="teal">edit</v-icon>
                    </v-btn>
                        {{ props.item.status}}</td>
                    <td class="text-xs-right body-1">{{ props.item.dtpedido}}</td>
                    <td class="text-xs-right body-1">{{ props.item.valortotal}}</td>

                    <td  @click="openEditDialog(props.item)" class="text-xs-right body-1">
                        <v-btn  @click="openEditDialog(props.item)"
                                icon class="mx-0">
                            <v-icon color="teal">edit</v-icon>
                        </v-btn>

                        {{ props.item.desconto}}%</td>
                    <td class="text-xs-right body-1">{{ props.item.valordesconto}}</td>

                    <router-link :to="{ path: '/pedidos-itens/dados', query: { pedido: props.item.id }}">
                        <v-btn  @click="editDetalhe(props.item)"
                                icon class="mx-0">
                            <v-icon color="teal">edit</v-icon>
                        </v-btn>
                    </router-link>
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
    export default {

        data: function () {
            return {

                date: new Date().toISOString().substr(0, 10),
                menu: false,
                modal: false,
                menu2: false,
                valid: true,
                dialogExcluir: false,
                disabledEmail:true,
                showmensagem:true,
                selected: [],
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
                listaCliente:  [],
                listaProduto:[],
                dialog: false,
                dialogProd: false,
                dialogStatus: false,
                dialogDesconto:false,
                headers: [
                    {text: 'id',value: 'id' },
                    {text: 'nome',value: 'nome' },
                    {text: 'status',value: 'status' },
                    {text: 'dtpedido', value: 'dtpedido'},
                    {text: 'valortotal', value: 'valortotal'},
                    {text: 'desconto', value: 'desconto'},
                    {text: 'valordesconto', value: 'valordesconto'},
                    {text: 'Adicionar Produtos', value: 'id'}
                ],
                items: [],
                editedIndex: -1,
                rulesNome: [
                    v => !!v || 'Nome é requerido!',
                    v => (v && v.length <= 45) || 'Campo não pode ser maior que 45 caracteres!'
                ],
                pedidos: {
                    value: false,
                    id: '',
                    cliente_id:'',
                    status: '',
                    produto_id:'',
                    qtde:'',
                    dtpedido:'',
                    valortotal: '',
                    desconto:'',
                    valordesconto:''
                },
                defaultItem: {
                    value: false,
                    id: '',
                    cliente_id:'',
                    status: '',
                    produto_id:'',
                    qtde:'',
                    dtpedido:'',
                    valortotal: '',
                    desconto:'',
                    valordesconto:''
                },
                listaStatus: [
                    { id: 'Aberto', nome: 'Aberto' },
                    { id: 'Pago', nome: 'Pago' },
                    { id: 'Cancelado', nome: 'Cancelado' },
                ],
                select: { id: '0', nome: 'Selecione' },
                listaCliente: [ ],

                select: { id: '0', nome: 'Selecione' },
                listaProduto: [ ],
            }
        },
        computed: {
            formTitle () {
                return this.editedIndex === -1 ? 'Novo Pedido' : 'Editar Pedido'
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
            }
        },
        mounted () {
            this.buscaCliente();
            this.buscaProduto();
            this.getDataFromApi();
            if (this.msg) {
                this.welcome = this.msg
            }
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
            changeSort (column) {
                if (this.pagination.sortBy === column) {
                    this.pagination.descending = !this.pagination.descending
                } else {
                    this.pagination.sortBy = column
                    this.pagination.descending = false
                }
            },
            buscaProduto: function(){
                axios.get('/pedidos/buscaProduto').then((res) => {
                    this.listaProduto= res.data;
                });
            },
            buscaCliente: function(){
                axios.get('/pedidos/buscaCliente').then((res) => {
                    this.listaCliente= res.data;
                });
            },
            changeStatus: function(value) {
                this.status = value
                this.getDataFromApi()
            },
            getDataFromApi: function () {
                this.loading = true;
                return new Promise((resolve, reject) => {
                    const {sortBy,status, descending, page, rowsPerPage} = this.pagination;
                    let config = {
                        params: {
                            sortBy:sortBy,
                            status:this.status,
                            descending:descending,
                            page: page,
                            rowsPerPage: rowsPerPage
                        },
                    }
                    axios.get('/pedidos/index', config)
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
            openEditDialog(item) {
                this.editedIndex = this.items.indexOf(item)
                this.pedidos = Object.assign({}, item)
                this.dialogDesconto = true;
            },
            openDialogStatus(item) {
                this.editedIndex = this.items.indexOf(item)
                this.pedidos = Object.assign({}, item)
                this.dialogStatus = true;
            },
            editItem (item) {
                this.editedIndex = this.items.indexOf(item)
                this.pedidos = Object.assign({}, item)
                this.dialogProd = true
            },
            editDetalhe (item) {
                this.editedIndex = this.items.indexOf(item)
                this.pedidos = Object.assign({}, item)
                //this.$router.push({name: 'pedidos-itens.dados', props: {guid:this.pedidos }});



            },
            btnInserir(){
                this.disabledEmail=false
            },
            deleteAll(){
                let config = {
                    params: {
                        id: this.checkValue
                    },
                }
                axios.get('/pedidos/destroyAll', config).then((res) => {
                    console.log(res.data);
                    this.dialogExcluir = false
                    this.getDataFromApi()
                    this.show = true
                }).catch(function (error) {
                    console.log(error);
                });
            },
            insert () {

                if (this.$refs.formPed.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido = app.pedidos;
                    axios.patch('/pedidos/store',  novoPedido)
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
            saveprod () {
                if (this.$refs.formPedProd.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido = app.pedidos;
                    axios.patch('/pedidos/storeProd',  novoPedido)
                        .then( ( resp ) => {
                            console.log(resp.data)
                            this.mensagem = 'Produto Adicionado com Sucesso!'
                            this.showmensagem = false;
                            this.tipo = "success"
                            this.closeProd ()
                            this.getDataFromApi()
                            //}
                        })
                        .catch(function (resp) {
                            console.log(resp.data)
                        });
                }
            },
            savedesconto() {
                if (this.$refs.formDesconto.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido = app.pedidos;
                    let uri = '/pedidos/updatedesconto/'+app.pedidos.id;
                    axios.post(uri, novoPedido).then((resp) => {
                        this.mensagem = ' Desconto Adicionado com Sucesso!'
                        this.showmensagem = false;
                        this.tipo = "success"
                        this.closeDesconto()
                        this.getDataFromApi()
                        console.log(resp.data)
                    }).catch(function (resp) {
                        console.log(resp.data);

                    });
                }
            },
            saveStatus() {
                if (this.$refs.formDesconto.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido = app.pedidos;
                    let uri = '/pedidos/updatestatus/'+app.pedidos.id;
                    axios.post(uri, novoPedido).then((resp) => {
                        this.mensagem = ' Desconto Adicionado com Sucesso!'
                        this.showmensagem = false;
                        this.tipo = "success"
                        this.closeStatus()
                        this.getDataFromApi()
                        console.log(resp.data)
                    }).catch(function (resp) {
                        console.log(resp.data);

                    });
                }
            },
            update () {
                if (this.$refs.formPed.validate()) {
                    this.$validator.validateAll()
                    var app = this;
                    var novoPedido = app.pedidos;
                    let uri = '/pedidos/update/'+app.pedidos.id;
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
            closeStatus () {
                this.dialogStatus = false
                setTimeout(() => {
                    this.pedidos = Object.assign({}, this.defaultItem)
                    this.editedIndex = -1
                }, 300)
            },
            closeProd () {
                this.dialogProd = false
                setTimeout(() => {
                    this.pedidos = Object.assign({}, this.defaultItem)
                    this.editedIndex = -1
                }, 300)
            },
            closeDesconto () {
                this.dialogDesconto= false
                setTimeout(() => {
                    this.pedidos = Object.assign({}, this.defaultItem)
                    this.editedIndex = -1
                }, 300)
            },
            closeProd () {
                this.dialogProd= false
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
            },
            updateDesconto () {

                this.insertDesc();

            }
        }
    }
</script>