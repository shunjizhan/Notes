import React from 'react'
import AddTodo from '../containers/AddTodo'
import VisibleTodoList from '../containers/VisibleTodoList'
import Filter from './Filter'


/*
  Big picture here is that these container components have access to root state and dispatch(), empowered by connect()().

  To pass state info to presentational component, we use mapStateToProps() to pass partial state info as props to this presentational component. 

  To change state using dispatch(), we use mapDispatchToProps() so that the component getting connected can has a function as prop. We call this function to dispatch an action to change state.
*/
const App = () => (
  <div>
    <AddTodo />
    <VisibleTodoList />    
    <Filter />
  </div>
);

export default App;