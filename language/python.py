# ============================================= #
# -------------------- Set -------------------- #
# ============================================= #
# A set object is an unordered collection of distinct hashable objects. It is implemented as hash table.
# Common uses include membership testing, removing duplicates from a sequence, and computing mathematical operations such as intersection, union, difference, and symmetric difference.
# Being an unordered collection, sets do not record element position or order of insertion. Accordingly, sets do not support indexing, slicing, or other sequence-like behavior.
                                                         
# Operation     | Example      | Complexity| Notes
# --------------+--------------+---------------+-------------------------------
# Length        | len(s)       | O(1)          |
# Add           | s.add(5)     | O(1)          |
# Containment   | x in/not in s| O(1)          | compare to list/tuple - O(N)
# Remove        | s.remove(..) | O(1)          | compare to list/tuple - O(N)
# Discard       | s.discard(..)| O(1)          | 
# Pop           | s.pop()      | O(1)          |
# Clear         | s.clear()    | O(1)          | similar to s = set()

# Construction  | set(...)     | O(len(...))   | depends on length of ... iterable
# check ==, !=  | s != t       | O(len(s))     | same as len(t): False in O(1) if the lengths are different
# <=/<          | s <= t       | O(len(s))     | issubset
# >=/>          | s >= t       | O(len(t))     | issuperset s <= t == t >= s
# Union         | s | t        | O(len(s)+len(t))
# Intersection  | s & t        | O(len(s)+len(t))
# Difference    | s - t        | O(len(s)+len(t))
# Symmetric Diff| s ^ t        | O(len(s)+len(t))

# Iteration     | for v in s:  | O(N)          |
# Copy          | s.copy()     | O(N)          |

set_example = {'jack', 'sjoerd'}


# ========================================== #
# --------------- Dictionary --------------- #
# ========================================== #
# A mapping object maps hashable values to arbitrary objects.
# A dictionary’s keys are almost arbitrary values. Values that are not hashable, that is, values containing lists, dictionaries or other mutable types (that are compared by value rather than by object identity) may not be used as keys.

# Operation     | Example      | Class         | Notes
# --------------+--------------+---------------+-------------------------------
# Index         | d[k]         | O(1)          |  
# Store         | d[k] = v     | O(1)          |  
# Length        | len(d)       | O(1)          |  
# Delete        | del d[k]     | O(1)          |  
# get/setdefault| d.method     | O(1)          |  
# Pop           | d.pop(k)     | O(1)          |  
# Pop item      | d.popitem()  | O(1)          |  
# Clear         | d.clear()    | O(1)          |   similar to s = {} or = dict()
# View          | d.keys()     | O(1)          |   same for d.values()
# Construction  | dict(...)    | O(len(...))   |   depends # (key,value) 2-tuples
# Iteration     | for k in d:  | O(N)          |   all forms: keys, values, items

a = dict(one=1, two=2, three=3)
b = {'one': 1, 'two': 2, 'three': 3}
c = dict(zip(['one', 'two', 'three'], [1, 2, 3]))
d = dict([('two', 2), ('one', 1), ('three', 3)])
e = dict({'three': 3, 'one': 1, 'two': 2})
a == b == c == d == e                       # True


# ========================================================================== #
# --------------- collections.Counter([iterable-or-mapping]) --------------- #
# ========================================================================== #
# A Counter is a dict subclass for counting hashable objects. It is an unordered collection where elements are stored as dictionary keys and their counts are stored as dictionary values. Counts are allowed to be any integer value including zero or negative counts. The Counter class is similar to bags or multisets in other languages.
cnt = Counter()
for word in ['red', 'blue', 'red', 'green', 'blue', 'blue']:
    cnt[word] += 1
print cnt    # Counter({'blue': 3, 'red': 2, 'green': 1})
print cnt.most_common(2)    # [('blue', 3), ('red', 2)]
# most_common(k) uses heapq.nlargest(k) 
# time: O(n*logk), when k is small almost linear O(n)

# initializations
c = Counter('gallahad')                 # Counter({'a': 3, 'l': 2, 'h': 1, 'g': 1, 'd': 1})
c = Counter({'red': 4, 'blue': 2})      # Counter({'red': 4, 'blue': 2})
c = Counter(cats=4, dogs=8)             # Counter({'dogs': 8, 'cats': 4})

# Counter objects have a dictionary interface except that they return a zero count for missing items instead of raising a KeyError:
c = Counter(['eggs', 'ham'])
c['bacon']          # 0

# Setting a count to zero does not remove an element from a counter. Use del to remove it entirely:
c['sausage'] = 0                        # counter entry with a zero count
del c['sausage']                        # del actually removes the entry

# elements() Return an iterator over elements repeating each as many times as its count. Elements are returned in arbitrary order. If an element’s count is less than one, elements() will ignore it.
c = Counter(a=4, b=2, c=0, d=-2)
iterable = c.elements()            # <itertools.chain object at 0x100633910>
print list(iterable)               # ['a', 'a', 'a', 'a', 'b', 'b']

# mathematical operations
c = Counter(a=4, b=2, c=0, d=-2)
d = Counter(a=1, b=2, c=3, d=4)
c.subtract(d)
print c                 # Counter({'a': 3, 'b': 0, 'c': -3, 'd': -6})

c = Counter(a=3, b=1)
d = Counter(a=1, b=2)
print c + d                 # add two counters together:  c[x] + d[x] => Counter({'a': 4, 'b': 3})
print c - d                 # subtract (keeping only positive counts) => Counter({'a': 2})
print c & d                 # intersection:  min(c[x], d[x]) => Counter({'a': 1, 'b': 1})
print c | d                 # union:  max(c[x], d[x]) => Counter({'a': 3, 'b': 2})

# other functions
sum(c.values())                 # total of all counts
c.clear()                       # reset all counts
list(c)                         # list unique elements
set(c)                          # convert to a set
dict(c)                         # convert to a regular dictionary
c.items()                       # convert to a list of (elem, cnt) pairs
Counter(dict(list_of_pairs))    # convert from a list of (elem, cnt) pairs
c.most_common()[:-n-1:-1]       # n least common elements
c += Counter()                  # remove zero and negative counts


# ======================================================================= #
# --------------- collections.deque([iterable[, maxlen]]) --------------- #
# ======================================================================= #
# Deques are a generalization of stacks and queues (the name is pronounced “deck” and is short for “double-ended queue”). Deques support thread-safe, memory efficient appends and pops from either side of the deque with approximately the same O(1) performance in either direction.
# Though list objects support similar operations, they are optimized for fast fixed-length operations and incur O(n) memory movement costs for pop(0) and insert(0, v) operations which change both the size and position of the underlying data representation.
class Deque:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def addFront(self, item):
        self.items.append(item)

    def addRear(self, item):
        self.items.insert(0, item)

    def removeFront(self):
        return self.items.pop()

    def removeRear(self):
        return self.items.pop(0)

    def size(self):
        return len(self.items)

from collections import deque
d = deque('ghi')                 # make a new deque with three items
d.append('j')                    # add a new entry to the right side
d.appendleft('f')                # add a new entry to the left side
print d                          # deque(['f', 'g', 'h', 'i', 'j'])

print d.pop()                    # 'j'
print d.popleft()                # 'f'
print list(d)                    # ['g', 'h', 'i']
print list(reversed(d))          # ['i', 'h', 'g']
print 'h' in d                   # True
d.extend('jkl')                  # add multiple elements at once
print d                          # deque(['g', 'h', 'i', 'j', 'k', 'l'])
d.rotate(1)                      # right rotation
print d                          # deque(['l', 'g', 'h', 'i', 'j', 'k'])
d.rotate(-1)                     # left rotation
print d                          # deque(['g', 'h', 'i', 'j', 'k', 'l'])
print deque(reversed(d))         # make a new deque in reverse order => deque(['l', 'k', 'j', 'i', 'h', 'g'])
d.clear()                        # empty the deque
d.pop()                          # cannot pop from an empty deque => IndexError: pop from an empty deque
d.extendleft('abc')              # extendleft() reverses the input order
print d                          # deque(['c', 'b', 'a'])


# ====================================================== #
# -------------------- Heap (heapq) -------------------- #
# ====================================================== #
# A priority queue is common use for a heap
# Heaps are binary trees for which every parent node has a value less than or equal to any of its children. This implementation uses arrays for which heap[k] <= heap[2*k+1] and heap[k] <= heap[2*k+2] for all k, counting elements from zero. For the sake of comparison, non-existing elements are considered to be infinite. The interesting property of a heap is that its smallest element is always the root, heap[0].
# this is MIN HEAP: pop method returns the smallest item. (MAX HEAP is opposite)
'''
[x,   x, x,   x, x, x, x,       x, x, x, x, x, x]
lv0   lv1      lv2                lv3
both children are bigger than the parent
insertion: insert at last then perculate up, swap if parent bigger than it
deletion: move the last to top, perculate down, swap with the smallest children if it is smaller
'''

def heapsort(iterable):
    h = []
    for value in iterable:
        heappush(h, value)      # O(logn)
    return [heappop(h) for i in range(len(h))]
res = heapsort([1, 3, 5, 7, 9, 2, 4, 6, 8, 0]) # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

# make a list a min heap
a=[3, 6, 1]
heapify(a)          # O(n), O(1)
_heapify_max(a)     # O(n), O(1)
heappop(a)          # O(logn)

# nlargest(n, iterable[, key])
# nsmallest(n, iterable[, key])
a = [2, 4, 6]
nlargest(2, a)  # [6, 4]

# ============================================================ #
# -------------------- Binary Search Tree -------------------- #
# ============================================================ #
'''
*** for binary search tree ***
insertion: from node, bigger than node, move right, continue... vise versa
deletion: 
1) if a leaf: delete directly
2) if only have one child: make his child replace him
3) two child: find the smallest node in the right subtree and replace it
'''

# tree traversal
def preorder(tree):
    if tree:
        print tree.value
        preorder(tree.leftChild)
        preorder(tree.rightChild)

def postorder(tree):
    if tree:
        postorder(tree.leftChild)
        postorder(tree.rightChild)
        print tree.value

def inorder(tree):
    if tree:
        inorder(tree.leftChild)
        print tree.value
        inorder(tree.rightChild)

# ======================================================================= #
# ----------------------------- Linked List ----------------------------- #
# ======================================================================= #
'''
pros: O(1) insertion and deletion, expand exasily without knowing the size in advance
cons: O(k) time to access kth element
'''
class Node:
    def __init__(self, value):
        self.value = value
        self.next = None
        self.prev = None # for double linked list

a = node(1)
b = node(2)
a.next = b
print a.next.value # => 2


# ======================================================================= #
# ----------------------------- Hash Table ------------------------------ #
# ======================================================================= #
'''
pros: O(1) insertion and deletion, expand exasily without knowing the size in advance
cons: O(k) time to access kth element
'''
class hashTable:
    def __init__(self, size):
        self.size = size
        self.slots = [None] * self.size
        self.data = [None] * self.size

    def put(self, key, data):
        slot = self.hash(key)
        while (self.slots[slot] != None):
            slot = self.rehash(slot)

        self.slots[slot] = key
        self.data[slot] = data

    def hash(self, key):
        return key % self.size

    def rehash(self, old_hash):
        return (old_hash + 1) % self.size

    def get(self, key):
        data = None
        start_slot = self.hash(key)
        position = start_slot

        while (self.slots[position] != None):
            if self.slots[position] == key:
                return self.data[position]
            else:
                position = self.rehash(position)
                if position == start_slot:
                    break
        return None

    # so we can use h[key] = value to call put()
    # and h[key] to call get()
    def __setitem__(self, key, data):
        self.put(key, data)

    def __getitem__(self, key):
        return self.get(key)


# ===================================================================== #
# ----------------------------- Sorting ------------------------------- #
# ===================================================================== #
                Best        | Average         | Worst           | Space Worst
-----------------------------------------------------------------------------
Quicksort       Ω(n log(n)) | Θ(n log(n))     | O(n^2)          | O(log(n))
Mergesort       Ω(n log(n)) | Θ(n log(n))     | O(n log(n))     | O(n)
Timsort         Ω(n)        | Θ(n log(n))     | O(n log(n))     | O(n)
Heapsort        Ω(n log(n)) | Θ(n log(n))     | O(n log(n))     | O(1)
Bubble Sort     Ω(n)        | Θ(n^2)          | O(n^2)          | O(1)
Insertion Sort  Ω(n)        | Θ(n^2)          | O(n^2)          | O(1)
Selection Sort  Ω(n^2)      | Θ(n^2)          | O(n^2)          | O(1)
Tree Sort       Ω(n log(n)) | Θ(n log(n))     | O(n^2)          | O(n)
Shell Sort      Ω(n log(n)) | Θ(n(log(n))^2)  | O(n(log(n))^2)  | O(1)

# =============== bubble sort =============== #
# compare adjacent values
def bubble_sort(arr):
    for n in range(len(arr) - 1, 0, -1):
        for k in range(n):
            if arr[k] > arr[k + 1]:
                temp = arr[k]
                arr[k] = arr[k + 1]
                arr[k + 1] = temp

# =============== selection sort =============== #
# place the largest to the end, then second largest to next position...
def selection_sort(arr):
    for fill_slot in range(len(arr) - 1, 0, -1):
        max_position = 0
        for i in range(1, fill_slot + 1):
            if arr[i] > arr[max_position]:
                max_position = i

        temp = arr[fill_slot]
        arr[fill_slot] = arr[max_position]
        arr[max_position] = temp

# =============== insertion sort =============== #
# sort first 1, then first 2...
def insertion_sort(arr):
    for i in range(1, len(arr)):
        current_value = arr[i]
        position = i

        while (position > 0 and arr[position - 1] > current_value):
            arr[position] = arr[position - 1]
            position -= 1

        arr[position] = current_value

# =============== merge sort =============== #
# resursively break the arr into half, sort them and merge
def merge_sort(arr):
    if len(arr) > 1:
        mid = len(arr) / 2
        left_half = arr[:mid]
        right_half = arr[mid:]

        merge_sort(left_half)
        merge_sort(right_half)

        # merge two sub arrays
        i = j = k = 0
        while (i < len(left_half) and j < len(right_half)):
            if left_half[i] < right_half[j]:
                arr[k] = left_half[i]
                i += 1
            else:
                arr[k] = right_half[j]
                i += 1
            k += 1

        while i < len(left_half):
            arr[k] = left_half[i]
            i += 1
            k += 1
        while j < len(right_half):
            arr[k] = right_half[j]
            j += 1
            k += 1

# =============== quick sort =============== #
# use pivot value to split the array, move everything to pivot's left or right, then move the pivot to the 'middle'
def quick_sort(arr):
    quick_sort_help(arr, 0, len(arr)-1)

def quick_sort_help(arr, first, last):
    if first < last:
        split_point = partition(arr, first, last)

        quick_sort_help(arr, first, split_point - 1)
        quick_sort_help(arr, split_point + 1, last)

def partition(arr, first, last):
    pivot_value = arr[first]
    left_marker = first + 1
    right_marker = last

    # put every value < pivot to left side, other to right side
    # [{5}, 2, 6, 7, 1] pivot: {5}
    while True:
        while (left_marker <= right_marker and arr[left_marker] < pivot_value):
            left_marker += 1
        while (right_marker >= left_marker and arr[right_marker] >= pivot_value):
            right_marker -= 1

        if right_marker < left_marker:
            break
        else:
            # swap two values
            temp = arr[left_marker]
            arr[left_marker] = arr[right_marker]
            arr[right_marker] = temp

    # => [{5}, 2, 1, 7, 6]
    # swap pivot with the 'middle
    temp = arr[first]
    arr[first] = arr[right_marker]
    arr[right_marker] = temp
    # => [1, 2, {5}, 7, 6]

    return right_marker


# =============== sort in python =============== #
# key parameter: specify a function to be called on each list element prior to making comparisons
# The value of the key parameter should be a function that takes a single argument and returns a key to use for sorting purposes
print sorted("This is a test string from Andrew".split(), key=str.lower)    # ['a', 'Andrew', 'from', 'is', 'string', 'test', 'This']

# A common pattern is to sort complex objects using some of the object’s indices as keys.
student_tuples = [
    ('john', 'A', 15),
    ('jane', 'B', 12),
    ('dave', 'B', 10),
]
print sorted(student_tuples, key=lambda student: student[2])   # sort by age => [('dave', 'B', 10), ('jane', 'B', 12), ('john', 'A', 15)]

# The same technique works for objects with named attributes
class Student:
    def __init__(self, name, grade, age):
        self.name = name
        self.grade = grade
        self.age = age
    def __repr__(self):
        return repr((self.name, self.grade, self.age))

student_objects = [
    Student('john', 'A', 15),
    Student('jane', 'B', 12),
    Student('dave', 'B', 10),
]
print sorted(student_objects, key=lambda student: student.age)   # sort by age => [('dave', 'B', 10), ('jane', 'B', 12), ('john', 'A', 15)]

# more convenient way
from operator import itemgetter, attrgetter
print sorted(student_tuples, key=itemgetter(2))
print sorted(student_objects, key=attrgetter('age'))
# multiple levels of sorting
print sorted(student_tuples, key=itemgetter(1,2))   # sort by grade then by age => [('john', 'A', 15), ('dave', 'B', 10), ('jane', 'B', 12)]
print sorted(student_objects, key=attrgetter('grade', 'age'))   # same as above

# ===================================================================== #
# ----------------------------- Graph --------------------------------- #
# ===================================================================== #
# =============== adjacency list =============== #
# for a not fully connected graph (sparse), it will waste a lot of memory to use adjacency matrix to store all edges (lot of 0s)
# use adjacency list will save a lot of memory
'''
v1(graph[1]) -> {v2, v3}
v2(graph[2]) -> {v1}
v3(graph[3]) -> {v6. v2, v1}
'''
class Vertex:
    def __init__(self, key):
        self.id = key
        self.connectedTo = {}

    def addNeighbor(self, nbr, weight=1):
        self.connectedTo[nbr] = weight

    def getConnections(self):
        return self.connectedTo.keys()

    def getId(self):
        return self.id

    def getWeight(self, nbr):
        return self.connectedTo[nbr]

    def __str__(self):
        return str(self.id) + 'connected to: ' + str([x.id for x in self.connectedTo])

class Graph:    # directed
    __init__(self):
        self.vertList = {}
        self.numVertices = 0

    def addVertex(self, key):
        self.numVertices += 1
        newVertex = Vertex(key)
        self.vertList[key] = newVertex
        return newVertex

    def getVertex(self, n):
        if n in self.vertList:  # if n in the keys
            return self.vertList[n]
        else:
            return None

    def addEdge(self, f, t, weight=1):
        if f not in self.vertList:
            nv = self.addVertex(f)
        if t not in self.vertList:
            nv = self.addVertex(t)
        self.vertList[f].addNeighbor(self.vertList[t], weight)

    def getVertices(self):
        return self.vertList.keys()

    def __iter__(self):
        return iter(self.vertList.values())

    def __contains__(self, n):
        return n in self.vertList

# =============== BFS =============== #
# Breath-First search provides us with the ability to return the same results as DFS, but with the added guarantee to return the shortest-path first.
def bfs(graph, start):
    visited, queue = set(), [start]
    while queue:
        vertex = queue.pop(0)
        if vertex not in visited:
            visited.add(vertex)
            connected = graph[vertex]
            queue.extend(connected - visited)
    return visited

# return all possible paths
def bfs_paths(graph, start, goal):
    queue = [(start, [start])]
    while queue:
        (vertex, path) = queue.pop(0)
        for next_v in (graph[vertex] - set(path)):
            if next_v == goal:
                yield path + [next_v]
            else:
                queue.append((next_v, path + [next_v]))

print list(bfs_paths(graph, 'A', 'F'))  # [['A', 'C', 'F'], ['A', 'B', 'E', 'F']]

# the fisrt path in BFS is always the shortest
def shortest_path(graph, start, goal):
    try:
        return next(bfs_paths(graph, start, goal))  # next() tell generator to generate next item
    except StopIteration:
        return None

# EX: word ladder problem: only change one letter each time: POLE => PALE => SALE => SAGE
def buildGraph(words):  
    # assume all words same length 
    # add edge between all words that differ by one letter
    d = {}  # find all substring, and save as {substring => [string1, string2]}
    for word in words:
        for i in range(len(word)):
            substring = word[:i] + word[i+1:]   # 'aaa'[100:] => '', no index error
            if substring in d:
                d[substring].append(word)
            else:
                d[substring] = [word]

    g = Graph()
    for substring in d.keys():
        for word1 in d[substring]:
            for word2 in d[substring]:
                if word1 != words2:
                    g.addEdge(word1, word2)

    return g

# =============== DFS =============== #
def dfs(g, start):
    visited = set()
    stack = [start]
    while stack:
        vertex = stack.pop()
        if vertex not in visited:
            visited.add(vertex)
            stack.extend(graph[vertex] - visited)
    return visited

# function variables (visited) are passed by reference! 
def dfs_recursive(graph, start, visited=None):
    if visited is None:
        visited = set()
    visited.add(start)
    for nxt in graph[start] - visited:
        dfs_recursive(graph, nxt, visited)
    return visited

# find all the paths
def dfs_paths(graph, start, goal):
    stack = [(start, [start])]
    while stack:
        (vertex, path) = stack.pop()
        for nxt in (graph[vertex] - set(path)):
            if nxt == goal:
                yield path + [nxt]
            else:
                stack.append((nxt, path + [nxt]))

print list(dfs_paths(graph, 'A', 'F')) # => [['A', 'B', 'E', 'F'], ['A', 'C', 'F']]

# =========================================================================== #
# ----------------------------- miscellaneous ------------------------------- #
# =========================================================================== #
# =============== xrange =============== #
# xrange doesn't actually generate a static list at run-time like range does. It creates the values as you need them with a special technique called yielding.
# If you have a really gigantic range you'd like to generate a list for, say one billion, xrange is the function to use. This is especially true if you have a really memory sensitive system such as a cell phone that you are working with, as range will use as much memory as it can to create your array of integers, which can result in a MemoryError and crash your program.
# If you'd like to iterate over the list multiple times, it's probably better to use range. This is because xrange has to generate an integer object every time you access an index, whereas range is a static list and the integers are already "there" to use.
for i in xrange(10):
    print(i)
# 0 - 9 same as range

# =============== star symbol =============== #
# The * operator unpacks an argument list. It allows you to call a function with the list items as individual arguments.
arguments = ["A", "B", "C"]
f(*arguments)       # f("A", "B", "C)


# =============== zip([iterable, ...]) =============== #
x = [1, 2, 3]
y = [4, 5, 6]
zipped = zip(x, y)  # [(1, 4), (2, 5), (3, 6)]
x2, y2 = zip(*zipped)
x == list(x2) and y == list(y2)     # True

# =============== generators =============== #
mylist = [x*x for x in range(3)]    # iterable
for i in mylist:
    print i

# Generators are iterators, a kind of iterable you can only iterate over once. Generators do not store all the values in memory, they generate the values on the fly
mygenerator = (x*x for x in range(3))   # generator
for i in mygenerator:                   # return the same result
    print i

# yield is a keyword that is used like return, except the function will return a generator.
def createGenerator():
   mylist = range(3)
   for i in mylist:
       yield i*i

mygenerator = createGenerator() # create a generator
print(mygenerator) # mygenerator is an object => <generator object createGenerator at 0xb7555c34>
for i in mygenerator:
    print i

# ====================================================================== #
# ============================== Examples ============================== #
# ====================================================================== #
'''
Recursion     | if there are a lot of repetetive works, such as apply same function to subtrees or substrings
Cache (DP)    | if there are a lot of repetitive calculations, such as recusion!
Binary Search | if the array is sorted, or need to search in some fixed/known range 
sort          | if it seems impossible to solve in O(n) time (so best possible would be O(n*logn)), can sort first

Set  | need O(1) time to check if something exist, or need remove duplicates
Dict | need to use some value as key for find similar/same things, or need to count some values. Usually if do some complex thing with array with O(n) time, use hash table!
heap | find k-largest/k-smallest numbers
List | need stack/queue/deque

'''
s1 = s1.replace(' ', '').lower()
s1 = sorted(s1)
s1.sort()               # in place
maxNum = max(a, b, c)
total = sum(a, b, c)
d = defaultDict(int)    # value is int
for num1, num2 in zip(arr1, arr2):
rev_words = ' '.join(reversed(s.split()))
res = phrase.startswith(word)
for index, letter in enumerate(s):


# ==========================================================================================
# check if two arrays are anagram: 
# two arrays have exactly same amount of any letters, ignoring uppter/lower cases and spaces

# sorting: O(n*logn), O(n)
def anagram(s1, s2):
    s1 = s1.replace(' ', '').lower()
    s2 = s2.replace(' ', '').lower()
    if len(s1) != len(s2):
        return False
    return sorted(s1) == sorted(s2)

# hash table: O(n), O(n)
def anagram(s1, s2):        
    s1 = s1.replace(' ', '').lower()
    s2 = s2.replace(' ', '').lower()
    if len(s1) != len(s2):
        return False
    
    count = {}
    for letter in s1:
        if letter in count:
            count[letter] += 1
        else:
            count[letter] = 1

    for letter in s2:
        if letter in count:
            count[letter] -= 1
        else:
            # return False directly?
            count[letter] = 1

    for k in count:
        if count[k] != 0:
            return False

    return True

# ==========================================================================================
# two sum: 
# given an integer array, output all the unique pairs that sum up to a specific k
# pair_sum([1,3,2,2], 4) => (1,3), (2,2)

# hash table: O(n)
def pair_sum(arr, k):
    if len(arr) < 2:
        return

    seen = set()
    output = set()

    for num in arr:
        target = k - num
        if target not in seen:
            seen.add(num)
        else:
            output.add( (min(num, target), max(num, target)) )

    print '\n'.join(map(str, list(output)))

# ==========================================================================================
# find the missing element:
# two array, the second is formed by shuffling the elements of the first array and deleting a random element. Find this element.
# finder([1,2,3], [3,1]) => 2

# brute force: O(n^2), O(1)
# sorting: O(n*logn), O(1)
def finder(arr1, arr2):
    arr1.sort()
    arr2.sort()

    for num1, num2 in zip(arr1, arr2):
        if num1 != num2:
            return num1

    return arr1[-1]

# hash table: O(n), O(n)
def finder(arr1, arr2):
    d = collections.defaultdict(int)

    for num in arr2:
        d[num] += 1

    for num in arr1:
        d[num] -= 1
        if d[num] == -1:
            return num
            
# take diff of two arrays: O(n), O(1)
# problem: sum two large overflow, or too small lost precision.
def finder(arr1, arr2):
    return sum(arr1) - sum(arr2)

# XOR all numbers: O(n), O(1)
def finder(arr1, arr2):
    result = 0
    for num in arr1 + arr2:
        result ^= num   
    return result

# ==========================================================================================
# largest continuous sum of array, which contain positive and negative numbers
# note that if all numebrs are positive, just return sum of all elements

# O(n), O(1)
def largest_cont_sum(arr):
    if len(arr) == 0:
        return 0

    max_sum = current_sum = arr[0]
    for num in arr[1:]:
        current_sum = max(current_sum + num, num)
        max_sum = max(current_sum, max_sum)

    return max_sum

# ==========================================================================================
# given a string of words, reverse all the words.
# 'This is the best' => 'best the is This'

# O(n)
def rev_words(s):
    # direct solutions
    # return " ".join(reversed(s.split()))
    # return " ".join(s.split()[::-1])
    words = []
    length = len(s)

    i = 0
    while i < length:
        if s[i] != ' ':
            word_start = i
            while i < length and s[i] != ' ':
                i += 1
            words.append(s[word_start:i])
        i += 1

    return " ".join(reversed(words))

# ==========================================================================================
# string compression (case sensitive):
# AAAABBBBCCCCCDDEEEE => A4B4C5D2E4

# O(n), O(n)
def compress(s):
    r = ""
    l = len(s)

    if l == 0:
        return ""

    if l == 1:
        return s + "1"

    last = s[0]
    cnt = 1
    i = 1
    while i < l:
        if s[i] == s[i - 1]:
            cnt += 1
        else:
            r = r + s[i - 1] + str(cnt)
            cnt = 1
        i += 1

    r = r + s[i - 1] + str(cnt)

    return r

# ==========================================================================================
# unique character of string: 
# given a string, see if it contains only unique chars, such as 'abcde', but not 'aabcd'

# O(n), O(n)
def uni_char(s):
    # directly return
    # return len(set(s)) == len(s)
    chars = set()
    for letter in s:
        if let in chars:
            return False
        else:
            chars.add(letter)
    return True


# ==========================================================================================
# Balance parentheses: (), [], {}, assume not other characters exists.

# O(n)
def balance_check(s):
    if len(s) % 2 != 0:
    return False

    opening = set('([{')
    matches = set([ ('(', ')'), ('[', ']'), ('{', '}') ])
    stack = []
    for paren in s:
        if paren in opening:
            stack.append(paren)
        else:
            if len(stack) == 0:
                return False
            last_open = stack.pop()
            if (last_open, parent) not in matches:
                return False

    return len(stack) == 0

# ==========================================================================================
# implement a queue using two stacks
class Queue2Stack:
    def __init__(self):
        self.instack = []
        self.outstack = []

    def enqueue(self, element):
        self.instack.append(element)

    # O(n) amortized time
    def dequeue(self):
        if not self.outstack:
            while self.instack:
                self.outstack.append(self.instack.pop())
        return self.outstack.pop()
                
# ==========================================================================================
# singly linked list cycle check
def cycle_check(node):
    marker1 = node
    marker2 = node

    while (marker2 != None and marker2.nextNode != None):
        marker1 = marker1.next
        marker2 = marker2.next.next

        if marker2 == marker1:
            return True

    return False

# ==========================================================================================
# linked list reversal with O(1) space, forward
def reverse(head):
    current = head
    previous = None
    nextNode = None
    while current:
        nextNode = current.next
        current.next = previous
        previous = current
        current = nextNode
    return previous

# ==========================================================================================
# linked list return the nth to last element
# use a 'block' of length n, when head reaches end, head is the element we are looking for
# O(n), O(1)
def nth_to_last(n, head):
    left_pointer = head
    right_pointer = head

    for i in range(n - 1):
        if not right_pointer.next:
            raise LookupError('Error: n is larger than the linked list')
        right_pointer = right_pointer.next

    while right_pointer.next:
        left_pointer = left_pointer.next
        right_pointer = right_pointer.next

    return left_pointer

# ==========================================================================================
# F: size of followGraph_edges 
# L: size of likeGraph_edges
# time (normal case): O(F) + O(L)+ O(L*logL) = O(F + L*logL)
# space: O(F) + O(L) + O(L) = O(F + L)
# time (special case when minLikeThreshold <= 0): O(L*logL), space: O(L)
def getRecommendedTweets(followGraph_edges, likeGraph_edges, targetUser, minLikeThreshold):
  # special case for minLikeThreshold <= 0, simply return all tweets
  # time: O(L + L*logL) = O(L*logL), space: O(L)
  if minLikeThreshold <= 0:
    all_twitts = set()
    for like_edge in likeGraph_edges:
        all_twitts.add(like_edge[1])
    return sorted(all_twitts)
    
  # use a set (hash table) to store people that targetUser is following
  # so that we can check if targetUser followes someone in O(1)
  # time: O(F), space: O(F)
  following = set()
  for follow_edge in followGraph_edges:
    if targetUser == follow_edge[0]:
      following.add(follow_edge[1])
  
  # if user follows no one, return empty list directly
  if len(following) == 0:
    return [] 
  
  # use a dictionary (hash table) to store the tweet and corresponding like count
  # time: O(L * (1 + 1 + 1)) = O(L), space O(L)
  like_count = defaultdict(int)
  for like_edge in likeGraph_edges:
    if like_edge[0] in following:
      tweet_ID = like_edge[1]
      like_count[tweet_ID] += 1
  
  # go through the tweet counts to find desired tweets for recommendation
  # store them in a heap to maintain order
  # time: O(L*logL), space: O(L)
  recommendations = []
  for tweet in like_count:
    count = like_count[tweet]
    if count >= minLikeThreshold:
      heappush(recommendations, tweet)
      # res.append(tweet)
        
  return recommendations

# ==========================================================================================
# compute sum of all digits
def sum_func(n):
    if len(str(n)) == 1:
        return n
    else:
        return n % 10 + sum_func(n / 10)    # python2

# ==========================================================================================
# determine if the phrase can be made from wordList
# This solution looks a little bit weird
def word_split(phrase, wordList, output=[]):
    for word in wordList:
        if phrase.startswith(word):
            output.append(word)
            remainingString = phrase[len(word):]
            return word_split(remainingString, wordList, output)
        else:
            return []   # no splitable
    return output

# ==========================================================================================
# reverse a string 
# O(n), O(n^2)
def reverse_recursive(s):
    if len(s) <= 1:
        return s
    else:
        return reverse_recursive(s[1:]) + s[0]

# ==========================================================================================
# find all the permutation of a string, repeat chars are treatly differently
# ['ab'] => ['ab', 'bc']   # ['xx'] => ['xx', 'xx']
def permute(s):
    if len(s) == 1:
        return [s]

    res = []
    for index, letter in enumerate(s):
        # permutations of rest letters except this letter
        permutations_rest = permute(s[:i] + s[i+1:])
        for perm in permutations_rest:
            res += [letter + perm]
    return res

# ==========================================================================================
# Fibonnaci sequence
def fib_iter(n):
    a, b = 0, 1
    for i in range(n):
        a, b = b, a+b
    return a

def fib_recursion(n):
    if (n == 0 or n == 1):
        return n
    else:
        return fib_recursion(n - 1) + fib_recursion(n - 2)

# Cache
n = 10      # we need to know in advance n
cache = [None] * (n + 1)
def fib_dynamic(n):
    if (n == 0 or n == 1):
        return n
    
    if cache[n] != None:
        return cache[n]

    cache[n] = fib_dynamic(n - 1) + fib_dynamic(n - 2)

    return cache[n]

# ==========================================================================================
# coin exchange problem
# given a total amount and a list of coin values, find the minimum amount of coins needed
# 10, [1, 5, 10] => only 1 coin is enough
def coin_exchange_recursion(target, coins)
    if target in coins:
        return 1

    min_coins = target # assume all coin value > 1
    useful_coins = [c for c in coins if c <= target]
    for i in useful_coins:
        num_coins = 1 + coin_exchange(target - i, useful_coins)
        if num_coins < min_coins:
            min_coins = num_coins

    return min_coins

# dynamic programming is more efficinet in time but less efficient in memory (in this case)
def coin_exchange_dynamic(target, coins, known_result=None):
    # top level initialization
    if known_result is None:
        known_result = [0] * (target + 1)

    # base case
    if target in coins:
        known_result[target] = 1
        return 1
    elif known_result[target] > 0:   
         # if the mincoins needed for current target is already calculated, return it directly
        return known_result[target]
    else:
        min_coins = target
        useful_coins = [c for c in coins if c <= target]
        for i in useful_coins:
            num_coins = 1 + coin_exchange_dynamic(target - i, useful_coins, known_result)
            if num_coins < min_coins:
                min_coins = num_coins
                known_result[target] = min_coins

        return min_coins

# find number of ways to make changes
# use bottom up algorithm
def find(target, coins):




# ==========================================================================================
# given a list of stock prices, calculate the maximun profit of buying and selling of 1 stock
# [2, 5, 1, 3, 8, 4] => 8 - 1 = 7
def profit(prices):
    # brute force all combinations O(n^2)
    # we use greddy algorithm O(n), O(1)
    if len(prices) < 2:
        raise Exception('need at leasr two prices')
    min_price = prices[0]
    # max_profit = 0 will not work if price is always decreseing
    # can set it to -999999 or price[1] - price[0]
    max_profit = 0  
    for price in prices:
        min_price = min(min_price, price)   # update min price so far
        cur_profit = price - min_price
        max_profit = max(max_profit, cur_profit)    # update the max profit
    return max_profit

# ==========================================================================================
# [1, 2, 3, 4] => [2*3*4, 1*3*4, 1*2*4, 1*2*3 ]
# cannot use product = 1*2*3*4 return [p/1, p/2, p/3, p/4]
# O(n), O(n)
def product(arr):
    size = len(arr)
    output = [1] * size
    product = 1
    i = 0

    # go forward to get product of all number before that index
    for i in range(size):
        output[i] *= product
        product *= arr[i]

    # go backward to get product of all number after that index
    product = 1
    for i in range(size - 1, -1, -1):
        output[i] *= product
        product *= arr[i]

    return output

# ==========================================================================================
# given a dice 1-7, simulate a dice 1-5
def dice5():
    roll = 7
    while roll > 5:
        roll = dice7()
    return roll

# given a dice 1-5, simulate a dice 1-7
def dice7():
    while True:
        roll_1 = dice5()
        roll_2 = dice5()
        num = (roll1 - 1) * 5 + rool2  # range [1,25] uniformly
        if num <= 21:
            return  num % 7 + 1

# ==========================================================================================
# find sqrt of n without using sqrt()
# O(n/2)
def sqrt(n):
    # every sqrt of n is less than n/2
    if n < 0:
        raise ValueError
    elif num == 1:
        return 1
    for k in range(num / 2 + 1):
        if k**2 == num:
            return k
        elif k**2 > num:
            return k - 1
    return k

# O(log(n/2))
def better_sqrt(n):
    if n < 0:
        raise ValueError
    elif num == 1:
        return 1
    
    # use binary search in the range [0, num/2 + 1]
    # note that this 'range' is sorted inherently
    low = 0
    high = num / 2 + 1
    while low < high:
        mid = low + (high - low) / 2
        square = mid**2
        if square == num:
            return mid
        elif square < num:
            low = mid
        else:
            high = mid
    return low

# ==========================================================================================
# remove the duplicate of a string keeping only the first occurance. 'tree traversal' => 'tre avsl'
# O(n)
def remove_dup(s):
    result = ''
    seen = set()
    for char in s:
        if char not in seen:
            seen.add(char)
            result += char

    return result

# ==========================================================================================
# given a list of id numbers (int) which contains duplicates (only pair, not >= 3 same id), find the unique id
# O(n), O(1)
def unique(id_list):
    unique_id = 0
    for i in id_list:
        unique_id ^= i      # xor everyting, pair will become 0
    return unique_id 

# ==========================================================================================
# take a list of unsorted prices (ints) and a maximum possible price value, return a sorted list of prices
# O(n + k), O(n + k) where n is the number of elements in input array and k is the range of input.
def sort(prices, max_price):
    prices_count = [0] * (max_price + 1)    # O(k) space
    for price in prices:
        prices_count[price] += 1
    sorted_prices = []                      # O(n) space
    for price, count in enumerate(prices_to_count):
        for time in range(count):
            sorted_prices.append(price)
    return sorted_prices

# ==========================================================================================
# find the largest 3-number product in a unsorted list (might contain negative)
# brute force: O(n^3)
# O(n)
def find(arr):
    high = max(arr[0], arr[1])
    low = min(arr[0], arr[1])
    high_prod2 = arr[0] * arr[1]
    low_prod2 = arr[0] * arr[1]         # in case have super absolute value large negative
    high_prod3 = arr[0] * arr[1] * arr[2]
    for num in arr[2:]:
        high_prod3 = max(high_prod3, num * high_prod2, num * low_prod2)
        high_prod2 = max(high_prod2, num * high, num * low)
        low_prod2 = min(low_prod2, num * high, num * low)
        high = max(high, num)
        low = min(low, num)

    return high_prod3

# ==========================================================================================
# given two rectangles by bottom-left coordinate and width and height, find the overlap if they have
# r = {'x': 1, 'y': 2, 'h': 5, 'w':3}

def overlap_1d(x1, l1, x2, l2):
    greater_left = max(x1, x2)
    lower_right = min(x1 + l1, x2 + l2)
    if greater_left >= lower:   # _____  ______
        return (None, None)
    else:
        overlap = lower_right - greater_left
        return (greater_left, overlap)

def rect_overlao(r1, r2):
    x_overlap, w_overlap = overlap_1d(r1['x'], r1['w'], r2['x'], r2['w'])
    y_overlap, h_overlap = overlap_1d(r1['y'], r1['h'], r2['y'], r2['h'])
    if not w_overlap or not h_overlap:
        print 'non overlap!'
        return None
    else:
        return {
            'x': x_overlap,
            'y': y_overlap,
            'w': w_overlap,
            'h': h_overlap
        }

# ==========================================================================================
# give a binary tree, determine if it a binary search tree

# Solution 1: O(n*logn), O(n)
def inorder(tree):
    if tree:
        inorder(tree.leftChild)
        tree_vals.append(tree.value)
        inorder(tree.rightChild)
tree_vals = []
inorder(tree)   # this should make tree_vals a sorted list
return treevals == sorted(treevals)

# Solution 2: use definition of binary search tree: left.value < this.value < right.value
# this takes longer and more space
def find_max(node):
    if not node:
        return float('-inf')
    max_left = find_max(node.leftChild)
    max_right = find_max(node.rightChild)
    return max(max_left, max_right, node.value)

def find_min(node):
    if not node:
        return float('inf')
    min_left = find_min(node.leftChild)
    min_right = find_min(node.rightChild)
    return min(max_left, max_right, node.value)

def verify(node):
    if not node:
        return True
    if (find_max(node.leftChild) <= node.value <= find_min(node.rightChild) 
        and verify(node.leftChild) 
        and verify(node.rightChild)):
        return True
    else:
        return False

# ==========================================================================================
# Tree level order print
# given a tree, print nodes in each level, separated by the new line
# this is not suitable to use recursion, since recursion is similar to the depth first search
def levelOrderPrint(tree):
    if not tree:
        return

    nodes = collections.deque([tree])
    currentCount = 1
    nextCount = 0

    while len(nodes) != 0:
        currentNode = nodes.popleft()
        current -= 1

        print currentNode.value

        if currentNode.left:
            nodes.append(currentNode.left)
            nextCount += 1

        if currentNode.right:
            nodes.append(currentNode.right)
            nextCount += 1

        if currentCount == 0:   # end of this level
            print '\n'
            currentCount, nextCount = nextCount, currentCount


# ==========================================================================================
# Trim a binary search tree
# Given a binary search tree and min, max, return a binary search tree that all values are in [min, max]
def trimBST(tree, minVal, maxVal):
    if not tree:
        return

    # post order (bottom up traversal)! Deal with childrens first
    tree.left = trimBST(tree.leftChild, minVal, maxVal)
    tree.right = trimBST(tree.rightChild, minVal, maxVal)

    treeVal = tree.value
    if minVal <= treeVal <= maxVal:
        return tree
    if treeVal < minVal:
        return tree.rightChild
    if treeVal > maxVal:
        return tree.leftChild



























# ====================================================================== #
# ============================== Interview ============================= #
# ====================================================================== #
'''
tips:
1) ask for clarification if see some ambiguity during process
2) eliminate some unessential codes, such as Node class, ask interviewer if we can assume it already exist
3) code the important logics first, not the helpers
4) modulize the main logic, then implement each little part

after heared the question:
1) restate to question, to make sure understand the question correctly
2) ask about assumptions: all input data is valid? super large data? consider special cases?
3) give some exmaples: make it as general as possible

4) give the most intuitive (brute force) solution, state it but not code it
5) tell interviewer that we will figure out a more optimal solution

6) test with some small sample inputs, and/or edge cases
'''

'''
My name is Shunji Zhan, which is hard to pronounce, but anyways.. I am a first year graduate student at UC Los Angeles, studying computer science.  Previously I had an internship in Procore, where I learned and used React, build a lot of front-end stuff, and I wrote one of my favorite project react-folder-tree, which I published on NPM (which the permission of my manager). That's a react-folder-tree library and a lot of people use it, 242 downloads yesterday! I feel accomplished that my code helped so many people. That's one reason I wanted to work for facebook, since React is maintains and written by facebook, it would be amazing if I can even contribute to it in the future.

I focus on graduate study on machine learning, and I learned a lot machine learning and data mining stuff. Recently I am the team lead for group of 5 people, doing the data mining project, which uses twitter to predict stock price. And that's one reason I chose facebook, since when I talk to my friend at facebook what she was doing recently, she said she was training some models, and I would be super excited if I can train and even build some model in real industry, rather than these toy applications.

Personally I like bockchain technology, have you heared of bitcoin? I hope I will have chance to implement some blockchain applications. Also I like playing basketball a lot, I was the captain for entramural basketball for 4 years in college.
'''

'''
What is the main language that we will be using for this potential position?
Can you tell me one of your favorite thing working at facebook, and one least favorite thing?
Based my coding just now, what do you think I should improve, or general suggestions my coding styles, logic, etc..
next steps of interview
'''






