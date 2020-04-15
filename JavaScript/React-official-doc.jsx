/* ----------------------------------------------- */
/* --------------- Main Concepts ----------------- */
/* ----------------------------------------------- */
// Note: Always start component names with a capital letter.
// React treats components starting with lowercase letters as DOM tags.For example, <div /> represents an HTML div tag, but < Welcome /> represents a component and requires Welcome to be in scope.

// All React components must act like pure functions with respect to their props.
  
// There are three things you should know about setState():
// 1) Do Not Modify State Directly, use setState()
// 2) State Updates May Be Asynchronous.React may batch multiple setState() calls into a single update for performance.Because this.props and this.state may be updated asynchronously, you should not rely on their values for calculating the next state.
// for example this might fail:
this.setState({
  counter: this.state.counter + this.props.increment,
});
// instead, use a second form of setState() that accepts a function rather than an object. 
this.setState((state, props) => ({
  counter: state.counter + props.increment
}));
// 3) State Updates are Merged. When you call setState(), React merges the object you provide into the current state.


/* --------------
  The Data Flows Down
-------------- */
// Neither parent nor child components can know if a certain component is stateful or stateless, and they shouldn’t care whether it is defined as a function or a class. This is why state is often called local or encapsulated.It is not accessible to any component other than the one that owns and sets it.


/* --------------
  3 ways to give function 'this' context
-------------- */
// 1) use bind
this.handleClick = this.handleClick.bind(this);
// 2) use fat arrow function in definition. Best way!
handleClick = () => {
  console.log('this is:', this);
}
// 3) wrap it up using an additional function when passing to children. The problem with this syntax is that a different callback is created each time the it renders.
<button onClick={e => this.handleClick(e)}>
  Click me
</button>


/* --------------
  2 ways to pass id to event handler
-------------- */
<button onClick={(e) => this.deleteRow(id, e)}>Delete Row</button>
<button onClick={this.deleteRow.bind(this, id)}>Delete Row</button>


/* --------------
  Conditional Rendering
-------------- */
// Why we can do conditional rendering like {condition && <Component>}? Because in JavaScript, true && expression always evaluates to expression, and false && expression always evaluates to false. 

// other ways to do conditional rendering
<div>
  The user is <b>{isLoggedIn ? 'currently' : 'not'}</b> logged in.
</div>

<div>
  {isLoggedIn ? (
    <LogoutButton onClick={this.handleLogoutClick} />
  ) : (
      <LoginButton onClick={this.handleLoginClick} />
    )}
</div>



// Preventing Component from Rendering
function WarningBanner(props) {
  if (!props.warn) {
    return null;
  }
  // ......
}


/* --------------
  Lists and Keys
-------------- */
// You can build collections of elements and include them in JSX using curly braces {}.
const numbers = [1, 2, 3, 4, 5];
const listItems = numbers.map((number) =>
  <li>{number}</li>
);
ReactDOM.render(
  <ul>{listItems}</ul>,
  document.getElementById('root')
);

// Keys help React identify which items have changed, are added, or are removed. Keys should be given to the elements inside the array to give the elements a stable identity.The best way to pick a key is to use a string that uniquely identifies a list item among its siblings. Most often you would use IDs from your data as keys. When you don’t have stable IDs for rendered items, you may use the item index as a key as a last resort (if you don't provide a key index is default as key). We don’t recommend using indexes for keys if the order of items may change. This can negatively impact performance and may cause issues with component state. 

// Keys used within arrays should be unique among their siblings. However they don’t need to be globally unique. We can use the same keys when we produce two different arrays:

// Keys serve as a hint to React but they don’t get passed to your components. If you need the same value in your component, pass it explicitly as a prop with a different name
const content = posts.map((post) =>
  <Post
    key={post.id}
    id={post.id}
    title={post.title} />
);



/* --------------
  Embedding map() in JSX
-------------- */
function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map((number) =>
    <ListItem key={number.toString()} value={number} />
 );
  return (<ul>{listItems}</ul>);
}
// alternative way to write it
function NumberList(props) {
  const numbers = props.numbers;
  return (
  <ul>{
    numbers.map(num => {
      <ListItem key={num.toString()} value={num} />
    })}
  </ul>);
}



/* --------------
  Forms
-------------- */
/* ------------- Controlled Element --------------- */
// In HTML, form elements such as <input>, <textarea>, and <select> typically maintain their own state and update it based on user input. In React, mutable state is typically kept in the state property of components, and only updated with setState(). We want react to be the "single source of truth"
class NameForm extends React.Component {
  // here we makes the form to be controlled component
  // the input value is only managed by itself 
  state = { value: '' };

  handleChange = e => {
    this.setState({ value: e.target.value });
  }

  handleSubmit = e => {
    alert('A name was submitted: ' + this.state.value);
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Name:
          <input type="text" value={this.state.value} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

/* ------------- Handling Multiple Inputs --------------- */
// When you need to handle multiple controlled input elements, you can add a name attribute to each element and let the handler function choose what to do based on the value of event.target.name.
class Reservation extends React.Component {
  state = {
    isGoing: true,
    numberOfGuests: 2
  };

  handleInputChange = e => {
    const target = e.target;
    const value = target.type === 'checkbox' ? target.checked : target.value;
    const name = target.name;

    this.setState({
      [name]: value
    });
  }

  render() {
    return (
      <form>
        <label>
          Is going:
          <input
            name="isGoing"
            type="checkbox"
            checked={this.state.isGoing}
            onChange={this.handleInputChange} />
        </label>

        <br />

        <label>
          Number of guests:
          <input
            name="numberOfGuests"
            type="number"
            value={this.state.numberOfGuests}
            onChange={this.handleInputChange} />
        </label>
      </form>
    );
  }
}



/* --------------
  Composition vs Inheritance
-------------- */
// we recommend using composition instead of inheritance to reuse code between components. At Facebook, we use React in thousands of components, and we haven’t found any use cases where we would recommend creating component inheritance hierarchies.

/* ---------------- Containment ---------------- */
// Some components don’t know their children ahead of time. This is especially common for components like Sidebar or Dialog that represent generic “boxes”. We recommend that such components use the special children prop to pass children elements directly into their output
function FancyBorder(props) {
  return (
    <div className={'FancyBorder FancyBorder-' + props.color}>
      {props.children}
    </div>
  );
}
// This lets other components pass arbitrary children to them by nesting the JSX. Anything inside the <FancyBorder> JSX tag gets passed into the FancyBorder component as a children prop. Since FancyBorder renders {props.children} inside a <div>, the passed elements appear in the final output.
function WelcomeDialog() {
  return (
    <FancyBorder color="blue">
      <h1 className="Dialog-title">
        Welcome
      </h1>
      <p className="Dialog-message">
        Thank you for visiting our spacecraft!
      </p>
    </FancyBorder>
  );
}









/* ----------------------------------------------- */
/* --------------- Advanced Guide ---------------- */
/* ----------------------------------------------- */

















/* ----------------------------------------------- */
/* -------------------- Hooks -------------------- */
/* ----------------------------------------------- */

/*
Hooks let you use state and other React features without writing a class.

Motivations:
1) It’ s hard to reuse stateful logic between components.React doesn’ t offer a way to“ attach” reusable behavior to a component. React needs a better primitive
for sharing stateful logic. Hooks allow you to reuse stateful logic without changing your component hierarchy.This makes it easy to share Hooks among many components or with the community.
2) Complex components become hard to understand, each lifecycle method often contains a mix of unrelated logic.Hooks
let you split one component into smaller functions based on what pieces are related(such as setting up a subscription or fetching data)
3) Hooks
let you use more of React’ s features without classes.
*/

import React, { useState } from 'react';

function Example() {
  // this example increament count by one everytime you click
  /*
    useState() returns a pair:  
    1) the current state value [count]
    2) and a function that lets you update it [setCount()]

    You can call this function from an event handler or somewhere else.It’s similar to this.setState() in a class, except it doesn’t merge the old and new state together.

    The only argument to useState() is the initial state. The initial state argument is only used during the first render
  */
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}

/* -------------------- 
  You can use the State Hook more than once in a single component
-------------------- */
function ExampleWithManyStates() {
  // Declare multiple state variables!
  const [age, setAge] = useState(42);
  const [fruit, setFruit] = useState('banana');
  const [todos, setTodos] = useState([{ text: 'Learn Hooks' }]);
  // ...
}

// Hooks are functions that let you “hook into” React state and lifecycle features from function components.Hooks don’t work inside classes — they let you use React without classes





/* ----------------------------------------------------- */
/* -------------------- Effect Hook -------------------- */
/* ----------------------------------------------------- */
/*
  You’ve likely performed data fetching, subscriptions, or manually changing the DOM from React components before. We call these operations “side effects” (or “effects” for short) because they can affect other components and can’t be done during rendering.

  The Effect Hook, useEffect, adds the ability to perform side effects from a function component. It serves the same purpose as componentDidMount, componentDidUpdate, and componentWillUnmount in React classes, but unified into a single API.
*/
import React, { useState, useEffect } from 'react';

function Example() {
  // this component sets the document title after React updates the DOM

  /*
    useEffect() is similar to componentDidMount and componentDidUpdate.

    When you call useEffect, you’re telling React to run your “effect” function after flushing changes to the DOM.
    
    Effects are declared inside the component so they have access to its props and state.By default, React runs the effects after every render — including the first render. 

    By default, React runs the effects after every render — including the first render.
  */
  useEffect(() => {
    document.title = `You clicked ${count} times`;
  });
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}


function FriendStatus(props) {
  const [isOnline, setIsOnline] = useState(null);

  function handleStatusChange(status) {
    setIsOnline(status.isOnline);
  }

  /* 
    Effects may also optionally specify how to “clean up” after them by returning a function. In this example, React would unsubscribe from our ChatAPI when the component unmounts, as well as before re-running the effect due to a subsequent render.
  */
  useEffect(() => {
    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);

    return () => {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  });

  if (isOnline === null) {
    return 'Loading...';
  }
  return isOnline ? 'Online' : 'Offline';
}

/* --------------------
  we can also use more than a single effect in a component
--------------------*/
function FriendStatusWithCounter(props) {
  const [count, setCount] = useState(0);
  useEffect(() => {
    document.title = `You clicked ${count} times`;
  });

  const [isOnline, setIsOnline] = useState(null);
  useEffect(() => {
    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  });

  function handleStatusChange(status) {
    setIsOnline(status.isOnline);
  }
}

/*
  Rules of hook:
  - Only call Hooks at the top level. Don’t call Hooks inside loops, conditions, or nested functions.
  - Only call Hooks from React function components. Don’t call Hooks from regular JavaScript functions. (There is just one other valid place to call Hooks — your own custom Hooks.)
*/





/* ----------------------------------------------------------------- */
/* -------------------- Building Your Own Hooks -------------------- */
/* ----------------------------------------------------------------- */

/* --------------- reuse hook in different component -------------------- */
// first extract the subscription logic to a Hook
function useFriendStatus(friendID) {
  const [isOnline, setIsOnline] = useState(null);

  function handleStatusChange(status) {
    setIsOnline(status.isOnline);
  }

  useEffect(() => {
    ChatAPI.subscribeToFriendStatus(friendID, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(friendID, handleStatusChange);
    };
  });

  return isOnline;
}
// use this hook in two components
function FriendStatus(props) {
  const isOnline = useFriendStatus(props.friend.id);

  if (isOnline === null) {
    return 'Loading...';
  }
  return isOnline ? 'Online' : 'Offline';
}

function FriendListItem(props) {
  const isOnline = useFriendStatus(props.friend.id);

  return (
    <li style={{ color: isOnline ? 'green' : 'black' }}>
      {props.friend.name}
    </li>
  );
}

/* 
  The state of these components is completely independent. Hooks are a way to reuse stateful logic, not state itself. We can even use the same custom Hook twice in one component.

  If a function’s name starts with ”use” and it calls other Hooks, we say it is a custom Hook. The useSomething naming convention is how our linter plugin is able to find bugs in the code using Hooks.
*/









/* ---------------------------------------------------- */
/* -------------------- State Hook -------------------- */
/* ---------------------------------------------------- */
/* --------------------
  This two classes are equivelent
--------------------*/
function Example() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>You clicked {count} times</p>
      <button onClick={() => setCount(count + 1)}>
        Click me
      </button>
    </div>
  );
}

class Example extends Component {
  state = { count: 0 };

  render() {
    return (
      <div>
        <p>You clicked {this.state.count} times</p>
        <button onClick={() => this.setState({ count: this.state.count + 1 })}>
          Click me
        </button>
      </div>
    );
  }
}

/* --------------------
  Hooks and Function Components
--------------------*/
// useState is a Hook that lets you add React state to function components. 
// In a function component, we have no this, so we can’t assign or read this.state. Instead, we call the useState Hook directly inside our component:

//  unlike this.setState in a class, updating a state variable always replaces it instead of merging it.





/* ---------------------------------------------------- */
/* -------------------- Effect Hook ------------------- */
/* ---------------------------------------------------- */
// There are two common kinds of side effects in React components: those that don’t require cleanup, and those that do.


/* --------------------
  Effects Without Cleanup
-------------------- */
// Sometimes, we want to run some additional code after React has updated the DOM. Network requests, manual DOM mutations, and logging are common examples of effects that don’t require a cleanup. We say that because we can run them and immediately forget about them.

// In React class components, the render method itself shouldn’t cause side effects. It would be too early — we typically want to perform our effects after React has updated the DOM. This is why in React classes, we put side effects into componentDidMount and componentDidUpdate. 

// above two lifecycle method can be written in useEffect as follow
componentDidMount() {
  // when first render
  document.title = `You clicked ${this.state.count} times`;
}

componentDidUpdate() {
  // all other renders
  document.title = `You clicked ${this.state.count} times`;
}

useEffect(() => {
  // all renders including the first render
  document.title = `You clicked ${count} times`;

  // Every time we re - render, we schedule a different effect, replacing the previous one.In a way, this makes the effects behave more like a part of the render result — each effect “belongs” to a particular render.
});

// Unlike componentDidMount or componentDidUpdate, effects scheduled with useEffect don’t block the browser from updating the screen. This makes your app feel more responsive. The majority of effects don’t need to happen synchronously. In the uncommon cases where they do (such as measuring the layout), there is a separate useLayoutEffect Hook with an API identical to useEffect.


/* --------------------
  Effects With Cleanup
-------------------- */
// For example, we might want to set up a subscription to some external data source. In that case, it is important to clean up so that we don’t introduce a memory leak!

// In a React class, you would typically set up a subscription in componentDidMount, and clean it up in componentWillUnmount. For example
componentDidMount() {
  ChatAPI.subscribeToFriendStatus(
    this.props.friend.id,
    this.handleStatusChange
  );
}

componentWillUnmount() {
  ChatAPI.unsubscribeFromFriendStatus(
    this.props.friend.id,
    this.handleStatusChange
  );
}

handleStatusChange(status) {
  this.setState({
    isOnline: status.isOnline
  });
}

// above code can be combined using useEffect() like this:
useEffect(() => {
  function handleStatusChange(status) {
    setIsOnline(status.isOnline);
  }

  ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);

  // The returned function in useEfect() is for clean up
  return function cleanup() {
    ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
  };

  // React performs the cleanup when the component unmounts. However, in this way, React cleans up effects from the previous render before running the effects next time. This will help avoid bugs, and can opt out if it creates performance issue.

  // note: We don’t have to return a named function from the effect. We called it cleanup here to clarify its purpose, but you could return an arrow function or call it something different.
});


/* --------------------
  Tips for useEffect
-------------------- */
// we can also use several effects, so we can separate code based on what it is doing. They are executed in the order they were specified
function FriendStatusWithCounter(props) {
  const [count, setCount] = useState(0);
  useEffect(() => {
    document.title = `You clicked ${count} times`;
  });

  const [isOnline, setIsOnline] = useState(null);
  useEffect(() => {
    function handleStatusChange(status) {
      setIsOnline(status.isOnline);
    }

    ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
    return () => {
      ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
    };
  });
}


// You can tell React to skip applying an effect if certain values haven’t changed between re-renders. To do so, pass an array as an optional second argument to useEffect
useEffect(() => {
  document.title = `You clicked ${count} times`;
}, [count]); // Only re-run the effect if count changes

useEffect(() => {
  function handleStatusChange(status) {
    setIsOnline(status.isOnline);
  }

  ChatAPI.subscribeToFriendStatus(props.friend.id, handleStatusChange);
  return () => {
    ChatAPI.unsubscribeFromFriendStatus(props.friend.id, handleStatusChange);
  };
}, [props.friend.id]); // Only re-subscribe if props.friend.id changes

// If you want to run an effect and clean it up only once (on mount and unmount), you can pass an empty array ([]) as a second argument. This tells React that your effect doesn’t depend on any values from props or state, so it never needs to re-run.


/* --------------------
  Hooks must be called on the top level of our components.
-------------------- */
// 🔴 We're breaking the first rule by using a Hook in a condition
if (name !== '') {
  useEffect(function persistForm() {
    localStorage.setItem('formData', name);
  });
  // this is because React relies on the order in which Hooks are called to know which state corresponds to which useState call. If this useEffect() doesn't run, the order will be messed.
}
// instead we should write this way
useEffect(function persistForm() {
  if (name !== '') {
    localStorage.setItem('formData', name);
  }
});





/* ------------------------------------------------------ */
/* --------------- Building Your Own Hooks ---------------*/
/* ------------------------------------------------------ */

/* --------------------
  Pass Information Between Hooks
-------------------- */
const friendList = [
  { id: 1, name: 'Phoebe' },
  { id: 2, name: 'Rachel' },
  { id: 3, name: 'Ross' },
];

function ChatRecipientPicker() {
  const [recipientID, setRecipientID] = useState(1);
  // here we pass recipientID, the information from above hook, to useFriendStatus(), our customed hook.
  const isRecipientOnline = useFriendStatus(recipientID);

  return (
    <>
      <Circle color={isRecipientOnline ? 'green' : 'red'} />
      <select
        value={recipientID}
        onChange={e => setRecipientID(Number(e.target.value))}
      >
        {friendList.map(friend => (
          <option key={friend.id} value={friend.id}>
            {friend.name}
          </option>
        ))}
      </select>
    </>
  );
}


/* --------------------
  UseReducer Hook
-------------------- */
// The need to manage local state with a reducer in a complex component is common enough that we’ve built the useReducer Hook right into React. Here we implemented under the hood as an example of writing hook using another hook.
function useReducer(reducer, initialState) {
  // here we can think of state is managed in the 'store'
  const [state, setState] = useState(initialState);

  // wrap the way to modify store by dispatch()
  function dispatch(action) {
    const nextState = reducer(state, action);
    setState(nextState);
  }

  return [state, dispatch];
}

function Todos() {
  const [todos, dispatch] = useReducer(todosReducer, []);

  function handleAddClick(text) {
    dispatch({ type: 'add', text });
  }

  // ...
}


