# Tree State Management
每一个state change都有点类似是一个reducer，这整个folder tree的state management有点像一个小型的redux，顶层的folder tree 去管理整个state，每一个action类似于一个reducer： action(oldState, params) => newState.

有点类似于手写了一个redux，然后也碰到了一些redux的坑，让我对redux的理解更深入了。比如说理解了为什么reducer必须是一个pure function，我在写的过程中就遇到了这个bug，更新state in place，结果update了以后发现树没有更新。后来发现在顶层setTreeState的rootnode没有变化，尽管已经有in place的变化，所以没有re-render。

一开始的解决方案是每一个state update都先deep clone一次，确保是100%的pure function。后来继续优化发现，这个不是一个非常严格的reducer，所以不需要很pure，更好的优化就是in place update，然后{ ...rootNode },这样优化了每次要deep clone的时间，从O(n) => O(1)

# 这样设计的好处
我特别喜欢pure function的概念，因为这样可以把每一个action抽象成一个reducer，这样又两个主要的好处：
1）逻辑清晰，非常容易理解，代码也很清晰，每一个reducer对应一个action，想加一个action就加一个reducer
2）容易unit test，这样可以保证运行上不出bug。
  - 之前的老版本设计上就有点混乱，有些action不容易unit test，因为跟整个folder tree的耦合度太高了，所以特别难debug
  - 在写unit test的同时，又是也会直接想到之前写的代码的错误，这个错误可能是手动测试不容易发现的。比如在写open的时候，一开始给每个node都加了open，在测试的时候没什么问题，但是在unit test的时候，把整个state写出来了，就发现，哦原来只有folder才应该有这个属性。所以在测试的时候就发现bug，不用等到人肉测试或者测试component的时候


# 从头到尾build一个工程化的项目
包括eslint，babel，jest，webpack。从中不仅可以学到工程化的知识，还能学到很多细节。比如很多eslint rule有错误，我就会去看为什么不建议这么做，会学到很多细节的知识，同时也会思考，自己做取舍，disable一些自己觉得不需要的eslint rules。

比如for...of的loop，eslint一般不建议这么做，因为这用到了generator。我就用一些工具把for of和.each() 编译成es5，就会看到确实for of会用到generator，所以代码复杂很多。但是经过一些思考，我觉得抛弃这个rule，因为我觉得“让代码快”，和“让代码简洁”是需要作出一些取舍的，比如C++和python，必然是python慢，但是python好写。而且当代的计算机，已近快到可以忽略这么点的“慢”，只要不是算法的问题，比如O(n) => O(n^2)，就不会有大问题。从10ms => 20ms用户根本不会感觉到。

从头到尾完成一个项目，还有一个学到的地方就是各种工程化的工具，流程。webpack是一个十分强大的工具，以前根本不会去注意webpack的细节，都是用create-react-app之类的，现在一点点build webpack的config，学到很多东西，不仅是config，还有怎么优化代码之类的，怎么样减少打包的size。其实可能一半的时间都用在工程化的建设上，以后就会有经验了。


# 内行的好处
有一句话叫做，外行看热闹，内行看门道。我自己写了一个public library以后，看到其它的public library就会感觉到，有好多东西可以学习。之前看别的public library的时候，觉得就是一团乱麻，根本不知道从何下手。现在有了很多的基础知识，基本扫一眼就知道了大概的结构，比如看到别人的webpack config，以前根本一点都看不懂，现在可以好好的读一读，看看有什么地方可以学习的。

有点像是锤子效应：拿着锤子，看什么都像钉子。我现在就是，看到什么东西，都想加到我的code里面。比如看到别人的webpack config，就会想这里有什么好的，我的webpack有什么可以改进的。包括我自己的网站，现在看所有网站，看到有趣的设计或者很炫酷的动画，就会想，我的网站有没有可以借鉴的地方？之前看到那个很酷的彩带动画，我还发邮件给他们网站的联系人，他们网站的联系人还回我了，把代码发给我，这是非常有趣的经历。


# 开发者也是项目经理
还有一点学到的很多东西就是，有时候在工作中，我们会有明确的要求，需要做什么功能和api。但是自己写一个library的好处是，自己既是开发者，又是产品经理。我需要自己去想很多东西，包括怎么样才能符合开发者的需求，同时不让这个library太复杂。更细节的方面，我要想，怎么去方便开发者上手，所以export了testData，因为我在自己使用public library的过程中，有时候看到文档不全面，或者没有例子，就会容易弃用。那我自己就做了一个demo网站，然后如果开发者想直接测试的话，可以直接拿到我的testData，非常方便。

# 挑战
写代码的方面还好，并没有特别难。

最有趣也是最有挑战的地方是，怎么样设计一个abstraction，让我的api interface尽可能的灵活，满足各种各样的需要。想要hardcode出来一个类似的项目，并不难，但是这样的话很多逻辑和UI都是定死的，只有一种固定的用法，一点都没有可拓展性。

这有点像是拼积木，我首先要把整个大城堡设计出来，也就是整个项目的宏观上的用法，逻辑等。接下来，要把这个大城堡拆开，拆成很多个小的积木，这样用户可以像拼积木一样，改装这个城堡，拆掉不用的东西，加上想要的东西。

在设计这个抽象化的过程中，我把所有逻辑分成三个不同的部分
- 内在逻辑：这部分是定死的，用户不能改变的，也不需要改变。比如tree state的结构，比如我这个就是一个tree，不能当做dropdown来用。
- 重要的可复用逻辑：这部分就是核心逻辑，不应该给用户customnize，而应该提供好，开箱即用。比如一个城堡的大门，墙壁等等。在这个项目中，核心逻辑就是对于tree state的CRUD，所以提供好了这些functionality。
- 可定制的部分：这点就是要思考，除了重要的可复用逻辑，应该提供什么接口给用户，让他们可以最大限度的custonmize。如果不提供这些接口，那项目就不extensible，没有可拓展性。在这个项目中，刚才提到了，treestate的CRUD是核心逻辑，然后有些用户可能不满足于CRUD，而想要更高级的用法。所以就use-tree-state就提供了两种不同的接口，可以在外面hardcode state transition logic, 然后直接调用setTreeState().或者有一个稍微抽象化过的接口，可以传入一个custom reducer, 让用户可以传入一个可复用的reducer，这个reducer的结构跟CRUD的结构很类似。

# 感想
在一遍又一遍设计抽象化以后，我总结出了一个原则：要么就给整块，要么就拆开把所有的积木（原材料）全部给他。用不用是他的事，给不给就是我的事了。

比如我最开始设计custom icon的时候，最开始只传入了一个defaultOnChange，后来有人问我，要怎么样拿到url，然后我思考了一下，发现只给defaultOnChange是有很大缺陷的，因为这样的话icon对这个node的data一无所知，所以在下一个版本里面，我就设计成把所有data都作为一个参数，这样的话有不仅可以拿到data，比如url，更可以根据这些data做出更复杂的handler，比如doc的例子，本来我们是不提供editable的选项的，但是用户现在可以很简单的就做出一个custom icon，用editable来选择是否画出来edit icon。

所以说，抽象化最重要的一个原则，就是你的接口要给到用户尽可能多的data，用不用是他的事，但不给的话就是我的错了。

# use-tree-state api的设计
传入一个reducer，导出一个经过包装的reducer，把treestate包装进去了。这个设计有点像是snabdom的init(),包装了domapi，这样用户可以直接用init()返回的patch，而不必要每次传入domapi$$


# 以后继续更新的地方
- 像create react app一样，可以建一层canvas，把compile error放到view里面。这样的好处：
  - 不需要去转去console看
  - 作为前端，很重要的一点就是，什么都要好看。在terminal里面的error太难看了，在view里面，就算是报错的信息，也可以处理的很好看。

- 继续看看有什么能够customize，比如以前的版本可以有custome file component和folder component。
