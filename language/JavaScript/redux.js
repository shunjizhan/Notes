/* -------------------------------------- */
/* --------------- Actions ---------------*/
/* -------------------------------------- */

// Actions are payloads of information that send data from your application to your store. They are the only source of information for the store. You send them to the store using store.dispatch(). Actions are plain JavaScript objects. Actions must have a type property that indicates the type of action being performed. Types should typically be defined as string constants.
const ADD_TODO = 'ADD_TODO'
const action = {
    type: ADD_TODO,
    text: 'Build my first Redux app'
}

// Once your app is large enough, you may want to move them into a separate module.
import { ADD_TODO, REMOVE_TODO } from '../actionTypes'


/* --------------------
  Action Creators
-------------------- */
// action creators simply return an action, this makes them portable and easy to test.
function addTodo(text) {
    return {
        type: ADD_TODO,
        text
    }
}

// In traditional Flux, action creators often trigger a dispatch when invoked
function addTodoWithDispatch(text) {
    const action = {
        type: ADD_TODO,
        text
    }
    dispatch(action)
}
// But in redux it is different, to actually initiate a dispatch, pass the result to the dispatch() function
dispatch(addTodo(text))
//  Alternatively, you can create a bound action creator that automatically dispatches:
const boundAddTodo = text => dispatch(addTodo(text))

// The dispatch() function can be accessed directly from the store as store.dispatch(), but more likely you'll access it using a helper like react-redux's connect(). 





/* -------------------------------------- */
/* --------------- Reducer ---------------*/
/* -------------------------------------- */
// Reducers specify how the application's state changes in response to actions sent to the store. Remember that actions only describe what happened, but don't describe how the application's state changes.

// In Redux, all the application state is stored as a single object. It's a good idea to think of its shape before writing any code. What's the minimal representation of your app's state as an object?

// he reducer is a pure function that takes the previous state and an action, and returns the next state. (previousState, action) => newState

import {
    ADD_TODO,
    TOGGLE_TODO,
    SET_VISIBILITY_FILTER,
    VisibilityFilters
} from './actions'

const initialState = {
    visibilityFilter: VisibilityFilters.SHOW_ALL,
    todos: []
}

function todoApp(state = initialState, action) {
    switch (action.type) {
        case SET_VISIBILITY_FILTER:
            return Object.assign({}, state, {
                visibilityFilter: action.filter
            })
        case ADD_TODO:
            // we never write directly to state or its fields, and instead we return new objects.
            return Object.assign({}, state, {
                todos: [
                    ...state.todos,
                    {
                        text: action.text,
                        completed: false
                    }
                ]
            })
        case TOGGLE_TODO:
            return Object.assign({}, state, {
                todos: state.todos.map((todo, index) => {
                    if (index === action.index) {
                        return Object.assign({}, todo, {
                            completed: !todo.completed
                        })
                    }
                    return todo
                })
            })
        default:
            // We return the previous state in the default case.It's important to return the previous state for any unknown action.
            return state
    }
}


/* --------------------
  splitting Reducers
-------------------- */
// we can split logic of todos reducer and UI reducer
function todos(state = [], action) {
    switch (action.type) {
        case ADD_TODO:
            return [
                ...state,
                {
                    text: action.text,
                    completed: false
                }
            ]
        case TOGGLE_TODO:
            return state.map((todo, index) => {
                if (index === action.index) {
                    return Object.assign({}, todo, {
                        completed: !todo.completed
                    })
                }
                return todo
            })
        default:
            return state
    }
}
function visibilityFilter(state = SHOW_ALL, action) {
    switch (action.type) {
        case SET_VISIBILITY_FILTER:
            return action.filter
        default:
            return state
    }
}

// combine two reducers to form the whole app reducer.
// Each of these reducers is managing its own part of the global state.The state parameter is different for every reducer, and corresponds to the part of the state it manages.
function todoApp(state = initialState, action) {
    return {
        visibilityFilter: visibilityFilter(state.visibilityFilter, action),
        todos: todos(state.todos, action)
    }

    // Note that todos also accepts state—but state is an array! Now todoApp gives todos just a slice of the state to manage, and todos knows how to update just that slice. This is called reducer composition, and it's the fundamental pattern of building Redux apps.
}

// a built-in way to combine reducers, equivalent as above function
import { combineReducers } from 'redux'
const todoApp = combineReducers({
    visibilityFilter,
    todos
})


// You could also give them different keys, or call functions differently.
const reducer = combineReducers({
    a: doSomethingWithA,
    b: processB,
    c: c
})
// equivalent to 
function reducer(state = {}, action) {
    return {
        a: doSomethingWithA(state.a, action),
        b: processB(state.b, action),
        c: c(state.c, action)
    }
}


/* --------------------
  ES6 Trick
-------------------- */
// ecause combineReducers expects an object, we can put all top-level reducers into a separate file, export each reducer function, and use import * as reducers to get them as an object with their names as the keys:
import { combineReducers } from 'redux'
import * as reducers from './reducers'

const todoApp = combineReducers(reducers)


/* -------------------------------------- */
/* ---------------- Store ----------------*/
/* -------------------------------------- */
/*
The store has the following responsibilities:
    - Holds application state;
    - Allows access to state via getState();
    - Allows state to be updated via dispatch(action);
    - Registers listeners via subscribe(listener);
    - Handles unregistering of listeners via the function returned by subscribe(listener).

It's important to note that you'll only have a single store in a Redux application. When you want to split your data handling logic, you'll use reducer composition instead of many stores.
*/

/* --------------------
  create store
-------------------- */
import { createStore } from 'redux'
import todoApp from './reducers'
const store = createStore(todoApp)

// Log the initial state
console.log(store.getState())

// Every time the state changes, log it
// Note that subscribe() returns a function for unregistering the listener
const unsubscribe = store.subscribe(() => console.log(store.getState()))

// Dispatch some actions
store.dispatch(addTodo('Learn about actions'))
store.dispatch(addTodo('Learn about reducers'))
store.dispatch(addTodo('Learn about store'))
store.dispatch(toggleTodo(0))
store.dispatch(toggleTodo(1))
store.dispatch(setVisibilityFilter(VisibilityFilters.SHOW_COMPLETED))

// Stop listening to state updates
unsubscribe()


/* --------------------
  data flow
-------------------- */
// The data lifecycle in any Redux app follows these 4 steps:

// 1) call store.dispatch(action). You can call store.dispatch(action) from anywhere in your app, including components and XHR callbacks, or even at scheduled intervals.

// 2) The Redux store calls the reducer function you gave it. The store will pass two arguments to the reducer: the current state tree and the action. For example, in the todo app, the root reducer might receive something like this:
// The current application state (list of todos and chosen filter)
let previousState = {
    visibleTodoFilter: 'SHOW_ALL',
    todos: [
        {
            text: 'Read the docs.',
            complete: false
        }
    ]
}

// The action being performed (adding a todo)
let action = {
    type: 'ADD_TODO',
    text: 'Understand the flow.'
}

// Your reducer returns the next application state
let nextState = todoApp(previousState, action)

// 3) The root reducer may combine the output of multiple reducers into a single state tree.

// 4) The Redux store saves the complete state tree returned by the root reducer. Now the state of the whole App is updated. Every listener registered with store.subscribe(listener) will now be invoked; listeners may call store.getState() to get the current state.






/* -------------------------------------- */
/* ---------- Redux with React------------*/
/* -------------------------------------- */
/*
    - Presentational Components: How things look (markup, styles)
    - Container Components: How things work (data fetching, state updates)

    Most of the components we'll write will be presentational, but we'll need to generate a few container components to connect them to the Redux store. 
    
    Technically, a container component is just a React component that uses store.subscribe() to read a part of the Redux state tree and supply props to a presentational component it renders.

    Rather than write container components by hand, we will generate them using the connect() function provided by React Redux.
*/

// To use connect(), you need to define a special function called mapStateToProps that describes how to transform the current Redux store state into the props you want to pass to a presentational component you are wrapping.
const getVisibleTodos = (todos, filter) => {
    switch (filter) {
        case 'SHOW_COMPLETED':
            return todos.filter(t => t.completed)
        case 'SHOW_ACTIVE':
            return todos.filter(t => !t.completed)
        case 'SHOW_ALL':
        default:
            return todos
    }
}

const mapStateToProps = state => {
    return {
        todos: getVisibleTodos(state.todos, state.visibilityFilter)
    }
}

/*
    In addition to reading the state, container components can dispatch actions. In a similar fashion, you can define a function called mapDispatchToProps() that receives the dispatch() method and returns callback props that you want to inject into the presentational component. For example, we want the VisibleTodoList to inject a prop called onTodoClick into the TodoList component, and we want onTodoClick to dispatch a TOGGLE_TODO action:
*/
const mapDispatchToProps = dispatch => {
    return {
        onTodoClick: id => {
            dispatch(toggleTodo(id))
        }
    }
}

// Finally, we create the VisibleTodoList by calling connect() and passing these two functions:
const VisibleTodoList = connect(
    mapStateToProps,
    mapDispatchToProps
)(TodoList);
