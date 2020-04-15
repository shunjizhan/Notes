import { connect } from 'react-redux'
import { toggleTodo } from '../actions'
import TodoList from '../components/TodoList'

const getVisibleTodos = (todos, filter) => {
    switch (filter) {
        case 'SHOW_ALL':
            return todos
        case 'SHOW_COMPLETED':
            return todos.filter(t => t.completed)
        case 'SHOW_ACTIVE':
            return todos.filter(t => !t.completed)
    }
}

const mapStateToProps = state => {
    /*
        return the visible todos as props
        it maps the root state to what we need in this component as format {
            todos: [...]
        }
    */
    return {
        todos: getVisibleTodos(state.todos, state.visibilityFilter)
    }
}

const mapDispatchToProps = dispatch => {
    return {
        toggleTodo: id => {
            dispatch(toggleTodo(id))
        }
    }
}

const VisibleTodoList = connect(
    mapStateToProps,
    mapDispatchToProps
)(TodoList)

export default VisibleTodoList