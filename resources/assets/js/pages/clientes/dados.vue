<template>
    <div>
        <v-alert v-if="!showmensagem" dismissible v-model="alert" :type="tipo" :value="true">
            {{ mensagem }}
        </v-alert>
        <v-dialog v-model="dialog" max-width="500px">
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
                                            v-model="clientes.nome"
                                            label="Nome"
                                            :counter="45"
                                            :rules="rulesNome"
                                            required
                                    ></v-text-field>
                                </v-flex>


                                <v-flex xs11 sm5>
                                    <v-text-field
                                            label="E-mail"
                                            v-model="clientes.email"
                                            :disabled="disabledEmail"
                                            :rules="rulesEmail"
                                            required
                                    ></v-text-field>
                                </v-flex>
                                <v-spacer></v-spacer>

                                <v-flex xs12 sm6 md4>
                                    <v-text-field
                                            v-bind:return-masked-value="true"
                                            mask="###########"

                                            label="CPF"
                                            v-model="clientes.cpf"
                                            :counter="11"
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
                    <td class="text-xs-right body-1">{{ props.item.nome}}</td>
                    <td class="text-xs-right body-1">{{ props.item.email}}</td>
                    <td class="text-xs-right body-1">{{ props.item.cpf}}</td>

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
    export default {
        data: function () {
            return {
                search: '',
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
                options: [],
                dialog: false,
                headers: [

                    {text: 'nome',value: 'nome' },
                    {text: 'email', value: 'email'},
                    {text: 'cpf', value: 'cpf'},
                    {text: 'Ação', value: 'id'}
                ],
                items: [],
                editedIndex: -1,
                rulesNome: [
                    v => !!v || 'Nome é requerido!',
                    v => (v && v.length <= 45) || 'Campo não pode ser maior que 45 caracteres!'
                ],
                clientes: {
                    value: false,
                    nome: '',
                    email:'',
                    cpf: ''
                },
                defaultItem: {
                    value: false,
                    nome: '',
                    email:'',
                    cpf: ''
                },
                nameRules: [
                    v => !!v || 'Nome é requerido!',
                    v => (v && v.length <= 45) || 'Campo não pode ser maior que 45 caracteres!'
                ],

                rulesEmail: [
                    v => !!v || 'E-mail é requerido!',
                    v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail inválido!'
                ]
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
            }
        },
        mounted () {

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
            changeSort (column) {
                if (this.pagination.sortBy === column) {
                    this.pagination.descending = !this.pagination.descending
                } else {
                    this.pagination.sortBy = column
                    this.pagination.descending = false
                }
            },
            getDataFromApi: function () {
                this.loading = true;
                return new Promise((resolve, reject) => {
                    const {sortBy, descending, page, rowsPerPage} = this.pagination;
                    let config = {
                        params: {
                            sortBy:sortBy,
                            descending:descending,
                            page: page,
                            rowsPerPage: rowsPerPage
                        },
                    }
                    axios.get('/clientes/index', config)
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
                this.clientes = Object.assign({}, item)
                this.disabledEmail = true
                this.dialog = true
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
                axios.get('/clientes/destroyAll', config).then((res) => {
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
                    var novoClientes = app.clientes;
                    axios.patch('/clientes/store',  novoClientes)
                        .then( ( resp ) => {
                            console.log(resp.data)
                            if (resp.data =="email"){
                                this.tipo = "warning"
                                this.showmensagem = false;
                                this.mensagem = 'E-mail ja existe!'
                            } else if (resp.data =="cpf"){
                                this.tipo = "warning"
                                this.showmensagem = false;
                                this.mensagem = 'CPF ja existe!'
                            } else{
                                this.mensagem = 'Adicionado com Sucesso!'
                                this.showmensagem = false;
                                this.tipo = "success"
                                this.close ()
                                this.getDataFromApi()
                            }
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
                    var novoClientes = app.clientes;
                    let uri = '/clientes/update/'+app.clientes.id;
                    axios.post(uri, novoClientes).then((resp) => {
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
                    this.clientes = Object.assign({}, this.defaultItem)
                    this.editedIndex = -1
                }, 300)
            },
            save () {
                if (this.editedIndex > -1) {
                    Object.assign(this.items[this.editedIndex], this.clientes)
                    this.update()
                } else {
                    this.insert()
                }
            }
        }
    }
</script>