/// # Módulo TodoList
/// 
/// Este módulo implementa uma lista de tarefas simples na blockchain Sui.
/// Permite criar, adicionar, remover e deletar itens de uma lista pessoal.
/// 
/// ## Estruturas
/// - `TodoList`: armazena os itens da lista de tarefas
/// 
/// ## Funções Públicas
/// - `new()`: cria uma nova lista de tarefas
/// - `add_item()`: adiciona um item à lista
/// - `remove()`: remove um item pelo índice
/// - `delete()`: deleta a lista inteira

module todolist::todolist;

use std::string::String;

/// Estrutura principal que representa uma lista de tarefas
/// 
/// # Campos
/// - `id`: identificador único do objeto na blockchain (necessário para `key`)
/// - `items`: vetor que armazena as strings dos itens da lista
/// 
/// # Abilities
/// - `key`: permite que o objeto seja armazenado na blockchain
/// - `store`: permite que o objeto seja transferido entre usuários
public struct TodoList has key, store {
    id: UID,
    items: vector<String>,
}

/// Cria uma nova lista de tarefas vazia
///
/// # Parâmetros
/// - `ctx`: contexto da transação (necessário para criar um novo objeto na blockchain)
///
/// # Comportamento
/// - Cria um novo objeto TodoList com um ID único
/// - Inicializa o vetor de itens vazio
/// - Transfere a lista para o endereço do remetente (quem chamou a função)
///
/// # Exemplo
/// ```
/// let ctx = &mut tx_context::TxContext;
/// new(ctx); // Cria uma nova lista
/// ```
public fun new(ctx: &mut TxContext){
    let list = TodoList {
        id: object::new(ctx),
        items: vector[],
    };

    transfer::transfer(list, tx_context::sender(ctx));
}

/// Adiciona um novo item à lista de tarefas
///
/// # Parâmetros
/// - `list`: referência mutável à TodoList (precisa ser mutável para modificar)
/// - `item`: uma String contendo o texto do item a ser adicionado
///
/// # Comportamento
/// - Adiciona o item ao final do vetor de itens
/// - A operação é imediata e sem custo computacional significativo
///
/// # Exemplo
/// ```
/// add_item(&mut list, string::utf8(b"Comprar leite"));
/// ```
public fun add_item(list: &mut TodoList, item: String){
    list.items.push_back(item);
}

/// Remove um item da lista pelo índice
///
/// # Parâmetros
/// - `list`: referência mutável à TodoList (precisa ser mutável para modificar)
/// - `index`: posição do item a ser removido (começando do 0)
///
/// # Comportamento
/// - Remove o item na posição especificada
/// - Os itens após o removido deslocam-se uma posição para trás
/// - Causa panic se o índice estiver fora dos limites
///
/// # Exemplo
/// ```
/// remove(&mut list, 0); // Remove o primeiro item
/// ```
public fun remove(list: &mut TodoList, index: u64){
   list.items.remove(index);
}

/// Deleta a lista de tarefas completamente
///
/// # Parâmetros
/// - `list`: o objeto TodoList a ser deletado (consome o objeto)
///
/// # Comportamento
/// - Remove a lista da blockchain
/// - Destrói o objeto e libera o espaço
/// - Após deletar, a lista não pode mais ser acessada
///
/// # Exemplo
/// ```
/// delete(list); // Deleta a lista inteira
/// ```
public fun delete(list: TodoList){
    let TodoList { id, items: _ } = list;
    id.delete()
}





