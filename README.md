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
