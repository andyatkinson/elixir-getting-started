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
