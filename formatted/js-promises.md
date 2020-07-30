# JavaScript Promises
**These are some systematic knowledge/examples of JS promises, as well as some relevant ES6 `async/await` syntax.**


## basic concepts
basic syntax
```js
new Promise( function(resolve, reject) { /* executor */ }   )
```
Promise是用来管理异步编程的，它本身不是异步的.`new Promise`的时候会立即把executor函数执行，只不过我们一般会在executor函数中处理一个异步操作。

basic example
```js
let promise = new Promise((resolve, reject) => {
    // do a thing, possibly async, then…
    if (everythingWorkedWell) {
        resolve("Stuff worked!");
    } else {
        reject(Error("It broke"));
    }
});

```


## 延迟绑定
Promise 采用了回调函数延迟绑定技术，在执行 resolve 函数的时候，回调函数还没有绑定，那么只能推迟回调函数的执行。
```js
// new Promise的时候先执行executor函数，打印出 1、2，Promise在执行resolve时，触发微任务，还是继续往下执行同步任务， 执行p1.then时，存储起来两个函数（此时这两个函数还没有执行）,然后打印出3，此时同步任务执行完成，最后执行刚刚那个微任务，从而执行.then中成功的方法。
let p1 = new Promise((resolve, reject) => {
  console.log(1);
  resolve('BTC');
  console.log(2);
})

p1.then(
  res => { console.log(res) },
  err => { console.log(err) }
)
console.log(3)
// 1
// 2
// 3
// BTC
```


## 错误处理
Promise 对象的错误具有“冒泡”性质，会一直向后传递，直到被 onReject 函数处理或 catch 语句捕获为止。具备了这样“冒泡”的特性后，就不需要在每个 Promise 对象中单独捕获异常了。
```js
/*
这段代码有三个 Promise 对象：p0～p2。无论哪个对象里面抛出异常，都可以通过最后一个对象 p2.catch 来捕获异常，通过这种方式可以将所有 Promise 对象的错误合并到一个函数来处理，这样就解决了每个任务都需要单独处理异常的问题。

通过这种方式，我们就消灭了嵌套调用和频繁的错误处理，这样使得我们写出来的代码更加优雅，更加符合人的线性思维。
*/
const executor = (resolve, reject) => {
  let rand = Math.random();
  rand > 0.5
    ? resolve(rand)
    : reject(rand);
}
let p0 = new Promise(executor);

let p1 = p0.then(val => {
  console.log('succeed 1')
  return new Promise(executor)
});

let p2 = p1.then(val => {
  console.log('succeed 2')
  return new Promise(executor)
});

p2.catch(err => console.log('error: ', err));
```


## promise chain
Everytime we call `then()`, it will return a new `Promise`, and we can chain them up.
```js
let p1 = new Promise((resolve, reject) => resolve(100));
let p2 = p1.then(res => {
  console.log('success 1: '+ res);
  return Promise.reject(1);
}, err => {
  console.log('failed 1: '+ err);
  return 200;
})

let p3 = p2.then(res => {
  console.log('success 2: '+ res);
}, err => {
  console.log('failed 2: '+ err);
})
/* =>
  success 1: 100
  failed 2: 1
*/
```
```js
new Promise(resolve => {
  resolve(a); // error since a is not defined
})
  .then(res => {
    console.log(`success 1: ${res}`);
    return res;
  }, err => {
    console.log(`fail 1: ${err}`);
    // here there is no exception, and we didn't return a rejected promise instance, so next then() will execute resolve() with undefined, since we didn't return anything here.
  })
  .then(
    res => console.log(`success 2: ${res}`),
    err => console.log(`fail 2: ${err}`)
  )
/* =>
  fail 1: ReferenceError: a is not defined
  success 2: undefined
*/
```


## async/await
```js
let p1 = new Promise(resolve => {
  setTimeout(() => {
    resolve()
  }, 1000)
});
let p2 = Promise.resolve();

(async function fn() {
  console.log(1)
  // 当代码执行到此行（先把此行），构建一个异步的微任务
  // 等待promise返回结果，并且await下面的代码也都被列到任务队列中
  await p1
  console.log(3)
  await p2
  console.log(4)
})();

console.log(2);
/*
  1
  2
  ...after some delay
  3
  4
*/
```

If `await` on a `promise`, it will only continue if the `promise` is `resolved`, otherwise lines below won't get executed.
```js
let p1 = Promise.reject(100);
(async function fn() {
  let result = await p1;
  console.log(1);  // this will not be executed
})();
```


## 微任务
基于微任务的技术有 MutationObserver、Promise 以及以 Promise 为基础开发出来的很多其他的技术，本题中resolve()、await fn()都是微任务。不管宏任务是否到达时间，以及放置的先后顺序，每次主线程执行栈为空的时候，引擎会优先处理微任务队列，处理完微任务队列里的所有任务，再去处理宏任务。
```js
// I am actually still a little confused about this...
console.log(1);
setTimeout(() => { console.log(9) }, 1000);

async function fn() {
  console.log(3);
  setTimeout(() => { 
    console.log(5);
  }, 20);
  return Promise.reject();
}

(async function run() {
  console.log(2);
  await fn();
  console.log('x');
})();

for(let i = 0; i < 99999999; i++) {
  /* this empty block executes for about 150ms */
};

// actually this will not reach 0ms, since according to HTML5 standard
// setTimeout() will at least wait 4ms.
setTimeout(() => {
  console.log(6);
  new Promise(resolve=>{
      console.log(7);
      resolve();
  }).then(() => { console.log(8)} );
}, 0);

console.log(4);

/* =>
1
2
3
4
[below are result from setTimeout()]
5
6
7
8
9
*/
```


## some tricks
```js
Promise.resolve('foo')
/* ---------- same as ---------- */
new Promise(resolve => resolve('foo'))
```


## to be continued... 
TODO: add remaining notes here

## wait until all promises are resovled
```js
let promise1 = Promise.resolve(3);
let promise2 = 42;
let promise3 = new Promise((resolve, reject) => {
    setTimeout(resolve, 100, 'foo');
});

Promise.all([promise1, promise2, promise3]).then(console.log); // => [3, 42, "foo"]
```

## use promise to create a get function
this example is kinda old though...
```js
function get(url) {
  return new Promise(function(resolve, reject) {
    var req = new XMLHttpRequest();
    req.open('GET', url);

    req.onload = function() {
      if (req.status == 200) {
        resolve(req.response);
      } else {
        reject(Error(req.statusText));
      }
    };

    req.onerror = function() {
      reject(Error("Network Error"));
    };

    req.send();
  });
}

// use it
get('story.json')
  .then(response => {
    return JSON.parse(response);
  }, error => {
    console.error("Failed!", error);
  });

// make it a function
function getJSON(url) {
  return get(url).then(JSON.parse);
}
```

## reference 
https://mp.weixin.qq.com/s/zcZwMRg9nymQrp4n6FEldA
