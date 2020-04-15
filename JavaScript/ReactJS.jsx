// ##### JSX #####
/*
JSX (Javascript XML syntax transform) is a syntax extension for JavaScript. It was written to be used with React. JSX code looks a lot like HTML.
What does "syntax extension" mean?
In this case, it means that JSX is not valid JavaScript. Web browsers can't read it!
If a JavaScript file contains JSX code, then that file will have to be compiled. That means that before the file reaches a web browser, a JSX compiler will translate any JSX into regular JavaScript.
*/

// what we need to use React
var React = require('react');
var ReactDOM = require('react-dom');

var navBar = <nav>I am a nav bar</nav>;
var title = <h1 id="title">Introduction to React.js: Part I</h1>; 	// expression can have id

var theGoogle = (            // nested expression
   <a href="https://www.google.net">
     <h1>
       Click me I am Gooooooooooogle
     </h1>
   </a>
);

// The first opening tag and the final closing tag of a JSX expression must belong to the same JSX element!
// the solution is usually simple: wrap the JSX expression in a <div></div>.
var paragraphs = ( 						// this won't work
  <p>I am a paragraph.</p> 
  <p>I, too, am a paragraph.</p>
);

ReactDOM.render(<h1>Hello world</h1>, document.getElementById('app'));

var toDoList = (
  <ol>
    <li>Learn React</li>
    <li>Become a Developer</li>
  </ol>
);
ReactDOM.render(toDoList, document.getElementById('app'));

// In React, for every DOM object, there is a corresponding "virtual DOM object."
// Manipulating the DOM is slow. Manipulating the virtual DOM is much faster, because nothing gets drawn onscreen.
// Once React knows which virtual DOM objects have changed, then React updates those objects, and only those objects, on the real DOM

// In JSX, you can't use the word class! You have to use className instead:
<h1 class="big">Hey</h1> 	// won't work!
<h1 className="big">Hey</h1>

// In JSX, you have to include the slash for self-closing tags
<br> 	// won't work
</br>

// Everything inside of the curly braces will be treated as regular JavaScript.
ReactDOM.render(
  <h1>{2 + 3}</h1>,		// this will put 5 on the screen
  document.getElementById('app')
);

var name = 'Gerdo';
// Access your variable from inside of a JSX expression:
var greeting = <p>Hello, {name}!</p>;

// Object properties are also often used to set attributes:
var pics = {
  panda: "http://bit.ly/1Tqltv5",
  owl: "http://bit.ly/1XGtkM3",
  owlCat: "http://bit.ly/1Upbczi"
}; 
var panda = <img src={pics.panda} />;
var owl = <img src={pics.owl} />;
var owlCat = <img src={pics.owlCat} />;

// event listener
function myFunc() { alert('hahahaha'); }
<img onClick={myFunc} />

// Here's a rule that you need to know: you can not inject an if statement into a JSX expression.
<h1>{ if(purchase.complete) 'Thank you for placing an order!' }</h1> 	// won't work

// option 1 is to write an if statement, and not inject it into JSX. This is a common way to express conditionals in JSX.
if (user.age >= drinkingAge) {
  var message = <h1>can drink!</h1>;
}
else {
  var message = <h1>NO!</h1>;
}

// option 2 is to use ernary operator
var message = (
  <h1>
    { age >= drinkingAge ? 'can drink!' : 'NO!' }
  </h1>
);

// option 3： use &&. && works best in conditionals that will sometimes do an action, but other times do nothing at all.
// Every time that you see && in this example, either some code will run, or else no code will run.
var tasty = (
  <ul>
    <li>Applesauce</li>
    { !baby && <li>Pizza</li> }
    { age > 15 && <li>Brussels Sprouts</li> }
    { age > 20 && <li>Oysters</li> }
    { age > 25 && <li>Grappa</li> }
  </ul>
);

/*  These two are the same!
<ul>             // 1
  <li>item 1</li>
  <li>item 2</li>
</ul>

var liArray = [   // 2
  <li>item 1</li>, 
  <li>item 2<li>, 
];
<ul>{liArray}</ul>
*/

var people = ['Rowe', 'Prevost', 'Gare'];
var peopleLIs = people.map(function(person, i){ return <li>{'person_' + i}</li>; });
ReactDOM.render(<ul>{peopleLIs}</ul>, document.getElementById('app')); 
// person_0
// person_1
// person_2

// A list needs keys if either of the following are true:
// - The list-items have memory from one render to the next. For instance, when a to-do list renders, each item must "remember" whether it was checked off. The items shouldn't get amnesia when they render.
// - A list's order might be shuffled. For instance, a list of search results might be shuffled from one render to the next.
<ul>
  <li key="li-01">Example1</li>
  <li key="li-02">Example2</li>
  <li key="li-03">Example3</li>
</ul>

var people = ['Rowe', 'Prevost', 'Gare'];
var peopleLIs = people.map(function(person, i){
  return <li key={'person_' + i}>{'person_' + i}</li>;
});
ReactDOM.render(<ul>{peopleLIs}</ul>, document.getElementById('app'));

// when a JSX element is compiled, it transforms into a React.createElement() call.
var h1 = <h1>Hello world</h1>;
var h1 = React.createElement("h1", null, "Hello, world"); // same as above

// ##### React component #####
// A component is a small, reusable chunk of code that is responsible for one job. That job is often to render some HTML.
// every component must come from a component class.
// Component class variable names must begin with capital letters! JSX elements can be either HTML-like, or component instances. JSX uses capitalization to distinguish between the two! 
// React.createClass takes one argument. That argument must be a JavaScript object. This object will act as a set of instructions, explaining to your component class how to build a React component.
var React = require('react');
var ReactDOM = require('react-dom');
var MyComponentClass = React.createClass({
  render: function () {     // must have this function, must have return statement. Usually, this return statement returns a JSX expression.
    return <h1>Hello world</h1>;
  }
});
// Whenever you make a React component instance, that component inherits all of the properties on its class's instructions object.
// ReactDOM.render will tell <MyComponentClass /> to call its render function.
ReactDOM.render(
  <MyComponentClass />,   // React component instance
  document.getElementById('app')
);

var Example = React.createClass({
  greeting: 'Yo!',
  render: function () {
    return <h1>{this.greeting}</h1>;    // <h1>{greeting}</h1> won't work
  }
});

var owl = {
  title: "Excellent Owl",
  src: "https://s3.amazonaws.com/codecademy-content/courses/React/react_photo-owl.jpg"
};
var Owl = React.createClass({
  render: function () {
    return (
      <div>
        <h1>{owl.title}</h1>
        <img src={owl.src} alt={owl.title} />
      </div>
    );
  }
});
ReactDOM.render(<Owl />, document.getElementById('app'));

// event handler
React.createClass({
  myFunc: function () { alert('Stop it.  Stop hovering.'); },
  render: function () {
    return (
      <div onHover={this.myFunc}>
      </div>;
    );
  }
});

// authorization form
var React = require('react');
var ReactDOM = require('react-dom');
var Contact = React.createClass({
  getInitialState: function () {
    return {
      password: 'swordfish',
      authorized: false
    };
  },

  authorize: function (e) {
    var password = e.target.querySelector(
      'input[type="password"]').value;
    var auth = password == this.state.password;
    this.setState({
      authorized: auth
    });
  },

  render: function () {
    var login = (
      <form action="#" onSubmit={this.authorize}>
        <input type="password" placeholder="Password" />
        <input type="submit" />
      </form>
      );

    var contactInfo = (
        <ul>
          <li>client@example.com</li>
          <li>555.555.5555</li>
        </ul>
      );

    return (
      <div id="authorization">
        <h1>{this.state.authorized? contactInfo : login}</h1>
      </div>
      );
  }
});
ReactDOM.render(<Contact />, document.getElementById('app'));

// ##### component interaction#####
//What makes React special is the ways in which components interact.
// When you use React.js, every JavaScript file in your application is invisible to every other JavaScript file by default. ProfilePage.js and NavBar.js can't see each other. If you want to use a variable that's declared in a different file, such as NavBar, then you have to import the file that you want. using require.
var React = require('react');
var ReactDOM = require('react-dom');
var NavBar = require('./NavBar'); //If your filepath doesn't have a file extension, then ".js" is assumed. 
var ProfilePage = React.createClass({
  render: function () {
    return (
      <div>
        <NavBar />            // one component render the other component
        <h1>All About Me!</h1>
      </div>
    );
  }
});
ReactDOM.render(<ProfilePage />, document.getElementById('app'));
//--- NavBar.js ---//
var React = require('react');
var NavBar = React.createClass({
  render: function () {
    var pages = ['home', 'blog', 'pics', 'bio', 'art', 'shop', 'about', 'contact'];
    var navLinks = pages.map(function(page){
      return ( <a href={'/' + page}> {page} </a> );
    });
    return <nav>{navLinks}</nav>;
  }
});
module.exports = NavBar;  // only export this module so other js won't need to import whole file
// Module systems of independent, importable files are a very popular way to organize code. React's specific module system comes from Node.js.

// A component's props is an object. It holds information about that component.
var Greeting = React.createClass({
  render: function () {
    return <h1>Hi there, {this.props.firstName}!</h1>;
  }
});
ReactDOM.render(
  <Greeting firstName='shun' />,  // if the value is not string us {}, such as {false}
  document.getElementById('app')
);

// You can also use props to make decisions.
var Greeting = React.createClass({
  render: function () {
    if (this.props.signedIn == false) {
      return <h1>GO AWAY</h1>;
    } else {
      return <h1>Hi there, {this.props.name}!</h1>;
    }
  }
});
// <Greeting name="Alison" signedIn={true}/>

// You can, and often will, pass functions as props. It is especially common to pass event handler functions.
var Button = require('./Button');
var Talker = React.createClass({
  handleClick: function () {
    for (var speech = '', i = 0; i < 10000; i++) {
      speech += 'blah ';
    }
    alert(speech);
  },
  render: function () {
    return <Button onClick={this.handleClick}/>;
  }
});
ReactDOM.render( <Talker />, document.getElementById('app') );
//--- Button.js ---//
var React = require('react');
var Button = React.createClass({
  render: function () {
    return (
      <button onClick={this.props.onClick}>
        Click me!
      </button>
    );
  }
});
module.exports = Button;

// this.props.children will return everything in between a component's opening and closing JSX tags.
// If a component has more than one child between its JSX tags, then this.props.children will return those children in an array. However, if a component has only one child, then this.props.children will return the single child, not wrapped in an array.
var List = require('./List');
var App = React.createClass({
  render: function () {
    return (
      <div>
        <List type='Living Musician'>
          <li>AAA</li>
          <li>BBB</li>
        </List>
      </div>
    );
  }
});

ReactDOM.render( <App />,  document.getElementById('app') );
//--- List.js ---//
var List = React.createClass({
  render: function () {
    var titleText = 'Favorite ' + this.props.type;
    if (this.props.children instanceof Array) {
      titleText += 's';
    }
    return (
      <div>
        <h1>{titleText}</h1>
        <ul>{this.props.children}</ul>  // this.props.children = [<li>AAA</li>, <li>BBB</li>];
      </div>
    );
  }
});
module.exports = List;

// default properties
var Button = React.createClass({
  getDefaultProps: function() {
    return { text: 'I am a button' };
  },
  render: function () {
    return ( <button>{this.props.text}</button> );
  }
});
ReactDOM.render( <Button />, document.getElementById('app') );

// Dynamic information is information that can change.
// There are two ways for a component to get dynamic information: props and state. Besides props and state, everything in a component should always stay exactly the same.
var green = '#39D1B4';
var yellow = '#FFD712';
var Toggle = React.createClass({
  getInitialState: function () {
    return { color: green };
  },
  changeColor: function () {
    var color = this.state.color == green ? yellow : green;
    this.setState({ color: color });
  },
  render: function () {
    return (
      <div style={{background: this.state.color}}>
        <button onClick={this.changeColor}>
          Change color
        </button>
      </div>
    );
  }
});
ReactDOM.render( <Toggle />, document.getElementById('app') );
// Any time that you call this.setState, this.setState AUTOMATICALLY calls render as soon as the state has changed. That is why you can't call this.setState from inside of the render function! (infinite loop!)

// Rendering is the only way for a component to pass props to another component. A component should never update this.props.
// A React component should use props to store information that can be changed, but can only be changed by a different component.
// A React component should use state to store information that the component itself can change.

 // Stateless components updating their parents' state
var Child = require('./Child');
var Parent = React.createClass({
  getInitialState: function () {
    return { name: 'Frarthur' };
  },
  changeName: function (newName) {
    this.setState({ name: newName });
  },
  render: function () {
    return ( <Child name={this.state.name} onChange={this.changeName}/> );
    // Automatic binding allows you to pass functions as props, and any this values in the functions' bodies will automatically refer to whatever they referred to when the function was defined. so this.changeName refer to Parent class's function, not the Child class's function!
  }
});
//--- Child.js ---//
var Child = React.createClass({
  handleChange: function (e) {
    var name = e.target.value;
    this.props.onChange(name);
  },
  render: function () {
    return (
      <div>
        <h1>Hey my name is {this.props.name}!</h1>
        <select id="great-names" onChange={this.handleChange}>
          <option value="Frarthur">Frarthur</option>
          <option value="Gromulus">Gromulus</option>
          <option value="Thinkpiece">Thinkpiece</option>
        </select>
      </div>
    );
  }
});
module.exports = Child;

// update sibling's attribute
var Parent = React.createClass({
  getInitialState: function () {
    return { name: 'Frarthur' };
  }, 
  changeName: function (newName) {
    this.setState({
      name: newName
    });
  },
  render: function () {
    return (
      <div>
        <Child onChange={this.changeName} />
        <Sibling name={this.state.name} />
      </div>
    );
  }
});
//--- Child.js ---//
var Child = React.createClass({
  handleChange: function (e) {
    var name = e.target.value;
    this.props.onChange(name);
  },
  render: function () {
    return (
      <div>
        <select 
          id="great-names" 
          onChange={this.handleChange}>
          
          <option value="Frarthur">Frarthur</option>
          <option value="Gromulus">Gromulus</option>
          <option value="Thinkpiece">Thinkpiece</option>
        </select>
      </div>
    );
  }
});
module.exports = Child;
var Sibling = React.createClass({
  render: function () {
    var name = this.props.name;
    return (
      <div>
        <h1>Hey, my name is {name}!</h1>
        <h2>Don't you think {name} is the prettiest name ever?</h2>
        <h2>Sure am glad that my parents picked {name}!</h2>
      </div>
    );
  }
});
module.exports = Sibling;

// ##### style in React #####
// outer curly braces is a javascript, inner is an object
<h1 style={{ color: 'red' }}>Hello world</h1>

var styles = {
  background: 'lightblue',
  color:      'darkred'
};
var styleMe = <h1 style={styles}>Please style me!  I am so bland!</h1>;

// In regular JavaScript, style names are written in hyphenated-lowercase:
var styles = {
  'margin-top':       "20px",
  'background-color': "green"
};
// In React, those same names are instead written in camelCase:
var styles = {
  marginTop:       "20px",
  backgroundColor: "green"
};

// In React, if you write a style value as a number, then the unit "px" is assumed.
{ fontSize: 30 }

// Separating container components from presentational components
// if a component has to have state, make calculations based on props, or manage any other complex logic, then that component shouldn't also have to render HTML-like JSX.
// Instead of rendering HTML-like JSX, the component should render another component. It should be that component's job to render HTML-like JSX.
// the presentational component will always end up like this: one render function, and no other properties.


// A component class written as a function is called a stateless functional component
// A component class written in the usual way:
var MyComponentClass = React.createClass({
  render: function(){
    return <h1>Hello world</h1>;
  }
});
// The same component class, written as a stateless functional component:
function MyComponentClass () {
  return <h1>Hello world</h1>;
}
// Works the same either way:
ReactDOM.render(
  <MyComponentClass />,
  document.getElementById('app')
);

// To access props of stateless function, give your stateless functional component a parameter. This parameter will automatically be equal to the component's props object.
// Normal way to display a prop:
var MyComponentClass = React.createClass({
  render: function () {
    return <h1>{this.props.title}</h1>;
  }
});
// Stateless functional component way to display a prop:
function MyComponentClass (props) {
  return <h1>{props.title}</h1>;
}

// required props:
var Runner = React.createClass({
  propTypes: {
    message:   React.PropTypes.string.isRequired,
    style:     React.PropTypes.object.isRequired,
    isMetric:  React.PropTypes.bool.isRequired,
    miles:     React.PropTypes.number.isRequired,
    milesToKM: React.PropTypes.func.isRequired,
    races:     React.PropTypes.array.isRequired
  },

  render: function () { }
});

// for stateless functional component:
function Example (props) {
  return <h1>{props.message}</h1>;
}
Example.propTypes = {
  message: React.PropTypes.string.isRequired
};

// An uncontrolled component is a component that maintains its own internal state. A controlled component is a component that does not maintain any internal state. Since a controlled component has no state, it must be controlled by someone else.
// The fact that <input /> keeps track of information makes it an uncontrolled component. It maintains its own internal state, by remembering data about itself.
// A controlled component, on the other hand, has no memory. If you ask it for information about itself, then it will have to get that information through props. Most React components are controlled.
// In React, when you give an <input /> a value attribute, then something strange happens: the <input /> BECOMES controlled. It stops using its internal storage. This is a more 'React' way of doing things.
var Input = React.createClass({
  getInitialState: function () {
    return {
      userInput: ""
    };
  },
  
  handleUserInput: function(e) {
    this.setState({
      userInput: e.target.value
    });
  },
  
  render: function () {
    return (
      <div>
        <input type="text" onChange={this.handleUserInput} value={this.state.userInput}/>
        <h1>{this.state.userInput}</h1>
      </div>
      );
  }
});

// ##### Lifecycle methods #####
// Lifecycle methods are methods that get called at certain moments in a component's life.

/*
A component "mounts" when it renders for the first time. This is when mounting lifecycle methods get called.
There are three mounting lifecycle methods:
  - componentWillMount
  - render
  - componentDidMount
When a component mounts, it automatically calls these three methods, in order.
*/
var Flashy = React.createClass({
  componentWillMount: function () {
    alert('AND NOW, FOR THE FIRST TIME EVER...  FLASHY!!!!'); // this will only be called once

  },
  componentDidMount: function () {
        // If your React app uses AJAX to fetch initial data from an API, then componentDidMount is the place to make that AJAX call. More generally, componentDidMount is a good place to connect a React app to external applications, such as web APIs or JavaScript frameworks. componentDidMount is also the place to set timers using setTimeout or setInterval.
        alert('YOU JUST WITNESSED THE DEBUT OF...  FLASHY!!!!!!!'); // this will only be called once
  },
  render: function () {
    alert('Flashy is rendering!');  // this will be called twice
    return (
      <h1 style={{ color: this.props.color }}>
        OOH LA LA LOOK AT ME I AM THE FLASHIEST
      </h1>
    );
  }
});
ReactDOM.render(
  <Flashy color='red' />,
  document.getElementById('app')
);
setTimeout(function () {
  ReactDOM.render(
    <Flashy color='green' />,
    document.getElementById('app')
  );
}, 2000);


/*
The first time that a component instance renders, it does not update. A component updates every time that it renders, starting with the second render.
There are five updating lifecycle methods:
  - componentWillReceiveProps   // only gets called if the component will receive props:
  - shouldComponentUpdate
  - componentWillUpdate
  - render
  - componentDidUpdate
Whenever a component instance updates, it automatically calls all five of these methods, in order.
*/

// componentWillReceiveProps automatically gets passed one argument: an object called nextProps. nextProps is a preview of the upcoming props object that the component is about to receive.
// A common use of componentWillReceiveProps: comparing incoming props to current props or state, and deciding what to render based on that comparison.
var TopNumber = React.createClass({
  propTypes: {
    number: React.PropTypes.number,
    game: React.PropTypes.bool
  },
  getInitialState: function () {
    return { 'highest': 0 };
  },
  componentWillReceiveProps: function(nextProps) {
    if (nextProps.number > this.state.highest) {
      this.setState({
        'highest': nextProps.number
      });
    }
  },
  render: function () {
    return (
      <h1>Top Number: {this.state.highest}</h1>
    );
  }
});

// shouldComponentUpdate should return either true or false.
// If shouldComponentUpdate returns true, then nothing noticeable happens. But if shouldComponentUpdate returns false, then the component will not update! None of the remaining lifecycle methods for that updating period will be called, including render.
shouldComponentUpdate: function (nextProps, nextState) {
  if ((this.props.text == nextProps.text) && 
    (this.state.subtext == nextState.subtext)) {
    alert("Props and state haven't changed, so I'm not gonna update!");
  return false;
} else {
  alert("Okay fine I will update.")
  return true;
}
}

// You cannot call this.setState from the body of componentWillUpdate! Which begs the question, why would you use it?
// The main purpose of componentWillUpdate is to interact with things outside of the React architecture. If you need to do non-React setup before a component renders, such as checking the window size or interacting with an API, then componentWillUpdate is a good place to do that.
componentWillUpdate: function (nextProps, nextState) {
  if (document.body.style.background != yellow) {
    document.body.style.background = yellow;
  } else if (!this.props.game && nextProps.game) {
  document.body.style.background = 'white';
  }
}

// When a component instance updates, componentDidUpdate gets called after any rendered HTML has finished loading.
// componentDidUpdate is usually used for interacting with things outside of the React environment, like the browser or APIs. It's similar to componentWillUpdate in that way, except that it gets called after render instead of before.
componentDidUpdate: function(prevProps, prevState) {
    if (this.state.latestClick < prevState.latestClick) {
      this.endGame();
    }
}

