import React from 'react'
import { connect } from 'react-redux'
import { addTodo } from '../actions'

const mapDispatchToProps = dispatch => {
    // map dispatch to a function that add todo item. This function can be accessed in props
    return {
        // addTodo() is a function that return a ACTION of json format
        addNewItem: newTodoItem => dispatch(addTodo(newTodoItem))
    }
};

// container component for adding to do item
let AddTodo = ({ dispatch, addNewItem }) => {
    let input;

    return (
        <div>
            <form
                onSubmit={e => {
                    e.preventDefault()
                    if (!input.value.trim()) {
                        return
                    }
    
                    const newTodoItem = input.value;
                    addNewItem(newTodoItem)
                    /*
                        we can also write in a shortcut way, if we don't use mapDispatchToProps() to map dispatch() to addNewItem()
                        dispatch(addTodo(newTodoItem))
                    */
                    input.value = ''
                }}
            >
                <input
                    ref={node => { input = node }}
                />
                <button type="submit">Add Todo</button>
            </form>
        </div>
    )
};

// This container has no props needed, so we don't need to mapStateToProps or mapDispatchToProps, so the first paranthesis is empty, so it doesn't receive any props parameters, only dispatch() that is given by connect().
AddTodo = connect(null, mapDispatchToProps)(AddTodo);

export default AddTodo;