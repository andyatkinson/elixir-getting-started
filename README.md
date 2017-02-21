http://elixir-lang.org/

##### Console

`iex`

#### Notes

Atoms are like symbols. e.g. `:hello`
Strings are encoded in UTF-8.
Strings are represented by binaries which are a sequence of bytes

String module contains helpers, e.g. `String.upcase("hello")`

##### Anonymous functions
Can be created inline. Delimited by `fn` and `end`

add = fn a, b -> a + b end

dot (".") is required to invoke an anonymous function. Dot ensures there is no ambiguity between calling an anonymous function and a named function of the same name.


##### Lists

Concat (`++`) or subtract (`--`)

++/2 and --/2 operators

e.g. [1]++[2] or [1,2]--[1]

Linked list, head and tail of list

```
list = [1,2,3]
hd(list)
tl(list)
```

[11, 12, 13] will print as "char list", '\v\f\r', single quotes are char lists, double quotes are strings.

##### Tuples

Curly brackets, can hold any value, like lists.

{1, true, :ok}

Tuples store elements contiguously in memory. Accessing by index is a fast operation.
Elixir data types are immutable.

String concatentation is done with the `<>` operator

##### Operators

Has double equals and triple equals. 1 == 1.0 #=> true vs. 1 === 1.0 #=> false

1 < :atom works because datatypes have a sort order, and so sorting algorithms don't have to worry about types.

The match operator (`=`)

```
x=1
1=x
```

2=x does not match, a MatchError is raised.

Pattern matching on tuples. Count and type needs to match.
`{a, b, c} = {:hello, "world", 42}`

##### Pin operator

Use pin operator when you want to match against existing variable's value rather than rebinding the variable.

e.g. ^x when you want to preserve current value

`cond` is similar to if else statements in other languages

```
cond do
  condition ->
  condition ->

end
```

if and unless

"keyword list" syntax style

`if true, do: 1 + 2`

### Binaries, strings, and char lists

Get a character's code point by using `?char` e.g. `?a` in iex

Define a binary like this: `<<1,2,3>>`. A binary is a sequence of bytes.
A char list is a list of code points.

##### Keyword lists and maps

When we have a 2-item tuples, and first item is an atom, we call it a "keyword list", e.g.

`list = [{:a, 1}, {:b, 2}]`

* keys must be atoms
* keys are ordered, as specified by developer
* keys can be given more than once

Maps

 * allow any value as a key
 * maps keys do not follow any ordering

e.g. `%{:a => 1, 2 => :b}

When a map is used in a pattern, it will always match on a subset of the given value.

`put_in/2` and `update_in/2` macros, `get_and_update_in/2` (extract value and update data)

##### Modules

```
defmodule Math do
  def sum(a, b) do
    a + b
  end
end
```

Math.sum(1,2)

##### Function capturing

Retrieve functions as a function using the name/arity style

Capture syntax can be used as shorthand for creating functions.
e.g. `fun = &(&1 + 1)`
`&(&1+1)` is same as `fn x -> x + 1 end`

&1 represents first argument

Default arguments are supported. Weird thing about function without body, when there are multiple clauses.

##### Recursion

Loops are different in a functional language compared with an imperative language
A function may have multiple clauses. The function matches that matches the args passed to it.

##### Ranges

Ranges are supported, e.g. `1..3`

Functions in the Enum module are "eager", each operation generates an intermiedate list until we reach the result.

`|>` pipe operator

`1..10_000 |> Enum.map(&(&1 * 3)) |> Enum.sum`

##### Streams

Streams support lazy operations. "Streams are lazy composable enumerables". Does not generate intermediate list. Invoked when we pass the underlying stream to the Enum module.

For large, or possible infinite collections.

```
stream = Stream.cycle([1,2,3])
Enum.take(stream, 10)
```

Stream.resource/3

##### Processes

Not OS processes. Not like threads. They are lightweight in terms of memory and CPU. Can have 10s or even 100s of thousands of processes running simultaneously.

`iex> pid = spawn fn -> 1 + 2 end`

`Process.alive?(pid)`

Send and receive messages between processes, send/2 and receive/1

##### Links

Process.link/1

spawn/1 and spawn_link/1 We link our processes to supervisors, which restart processes. Processes are isolated.

##### Tasks

Task.start/1
Task.start_link/1

Use Task to get better error reports

##### State

Using processes to maintain state and name registration are very common patterns

Elixir provides an abstraction layer called an "Agent" around state

`GenServer` for building generic servers

##### File I/O

`File` module

File.read/1, vs. File.read!/1 (latter returns contents of file instead of tuple, raises an error)
Without bang is preferred when handling different outcomes

```
case File.read(file) do
  {:ok, body}      -> # do something with the `body`
  {:error, reason} -> # handle the error caused by `reason`
end
```

Bang variation is good for handing errors

Processes and group leaders

Writing to stdio, actually sending message to group leader
`Process.group_leader`

iodata and chardata

alias, require and import ("directives", because they have lexical scope) Lexical scope means it may only be executed within the block where it is defined.

```
iex> import List, only: [duplicate: 2]
List
```

Module nesting
Module attributes

  1. annotate the module
  2. hey work as constants
  3. hey work as temporary module storage to be used during compilation


@moduledoc

Module attributes as constants, e.g. initial state

```
defmodule MyServer do
  @initial_state %{host: "147.0.0.1", port: 3456}
  IO.inspect @initial_state
end
```

As temporary storage (module attribute values read at compilation time not runtime)

##### Structs

```
defmodule User do
  defstruct name: "John", age: 25
end

%User{}
%User{age: 25, name: "Bill"}
john=%User{age: 25}
bill=%User{john | age: 30}
```

Structs are bare maps underneath

@enforce_keys to enforce certain keys are set

##### Protocols

Mechanism to achieve polymorphism

`defprotocol` and `defimpl`

Deriving, use implementation for `Any`

e.g. Derive the Size protocol, using the Any implementation
@derize [Size]

@fallback_to_any true

##### Built-in protocols

Enum, String.Chars (to_string), Inspect
Protocol consolidation

##### Comprehensions

* loop, filter, map into another list
* three parts: generators, filters, collectables

Pattern matching on the generator (left hand) side
Only pick up the "good" values

```
iex> values = [good: 1, good: 2, bad: 3, good: 4]
iex> for {:good, n} <- values, do: n * n
[1, 4, 16]
```

##### Sigils

Working with textual representations

`~r` create regular expressions

`iex> h sigil_r`

`~s` similar to creating double quoted strings, useful when string contains double quotes

`~w` (word list) e.g. ~w(foo bar baz)

Also support heredocs

##### try, catch, rescue

try and `after`, after runs whether try was successful or not

##### Types and specs

Dynamically typed, though comes with typespecs, which:

  * declare typed function signatures
  * declare custom data types


@type directive allows us to create our own type
We can use this type in the typespec
Can perform static code analysis using the type information

##### Behaviours

Kind of like an interface, a set of function signatures a module has to implement


##### Erlang libraries

Formatted text output, `:io.format/2`
crypto module
digraph (directed graphs) module
Erlang Term Storage, `ets` and `dets`
math module
queue module, double-ended FIFO
rand module
zip and zlib

##### First project

`mix.exs` file has project configuration

`mix compile`

Test files are elixir script files (no compilation necessary)

`mix test`

Mix supports environments:

```
:dev, :test, :prod
```

`mix help`

##### Agent

Can review processes section from getting started

Elixir is immutable where nothing is shared by default. To provide state, two main options:

  * Processes
  * ETS (Erlang Term Storage)

Agent (simple wrapper around state)
GenServer (generic servers, "processes"), sync and async, code reloading
GenEvent (generic event, "managers")
Task - async units of computation, spawn process, retrieve results later

All implemented on top of processes

##### GenServer

A genserver is implemented in two parts: the client API and the server callbacks

Two types of calls for genserver: calls and casts

Calls are synchronous, server must respond

Casts are async

When should we use monitors, and when should we use links?

Links are bi-directional (both sides crash). Monitor is uni-directional. Use monitors when you want to be informed of crashes, but not crash.

##### Supervisors

"Let it crash" - supervisor will start a fresh copy of the registry

`iex -S mix` vs. `iex -S mix run --no-start` to not start applications

Mix makes a distinction between projects and applications

Defines a new supervisor with a `:simple_one_for_one` strategy
No workers are started during the supervisor initialization
A new worker is started each time start_child/2 is started

"Supervision trees" - supervisors that supervise other supervisors

Start processes inside supervision trees so they are introspectable. Can use tools like Observer to introspect on them.
