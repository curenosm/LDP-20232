# Lenguajes de Programación - Tarea 3

# Integrantes 

| **Nombre** | **No. de cuenta** |
|---|---|
| *Cureño Sánchez Misael* | 418002485 |
| *González Mancera Ivette* | 316014490 |

<br>

---

<br>

## Ejercicios

<br>

1. Evalúa las siguientes expresiones usando el régimen de evaluación y alcance especificado en cada inciso.

<br>

- **a)**

<br>


```ml
{with {x {+ 2 2}}
    {with {y {+ x x}}
        {with {foo {fun {a} {- a y}}}
            {with {x {- 2 2}}
                {with {y {- x x}}
                    {foo -3}}}}}
```
- Evaluación glotona y alcance estático.

<table width="100%">
<tr>
  <th>Evaluación</th>
  <th>Pila de ejecución</th>
</tr>
<br>
<tr>
<td width="50%">
<br>

```ml
{with {y {+ x x}}
    {with {foo {fun {a} {- a y}}}
        {with {x {- 2 2}}
            {with {y {- x x}}
                {foo -3}}}}
```

</td>
<td>

```txt
---------
 x  |  4
---------
```

</td>
</tr>
</table><br><br>

<!---------------------------------------------------------------->

<table width="100%">
<tr>
<td width="50%">

```ml
{with {foo {fun {a} {- a y}}}
    {with {x {- 2 2}}
        {with {y {- x x}}
            {foo -3}}}
```

</td>
<td>

```txt
-------------------------
  y   |         8 
-------------------------
  x   |         4
-------------------------
```

</td>
</tr>
</table><br><br>

<!---------------------------------------------------------------->

<table width="100%">
<tr>
<td width="50%">

```ml
{with {x {- 2 2}}
    {with {y {- x x}}
        {foo -3}}
```

</td>
<td>

```txt
--------------------------
 foo  | {fun {a} {- a 8}} 
--------------------------
  y   |         8         
--------------------------
  x   |         4         
--------------------------
```

</td>
</tr>
</table><br><br>

<!---------------------------------------------------------------->

<table width="100%">
<tr>
<td width="50%">

```ml
{with {y {- x x}}
    {foo -3}}
```

</td>
<td>

```txt
--------------------------
   x  |         0         
--------------------------
 foo  | {fun {a} {- a 8}} 
--------------------------
  y   |         8         
--------------------------
  x   |         4         
--------------------------
```

</td>
</tr>
</table><br><br>

<!---------------------------------------------------------------->

<table width="100%">
<tr>
<td width="50%">

```ml
{foo -3}
```

</td>
<td>

```txt
--------------------------
   y  |         0         
--------------------------
   x  |         0         
--------------------------
 foo  | {fun {a} {- a 8}} 
--------------------------
  y   |         8         
--------------------------
  x   |         4         
--------------------------
```

</td>
</tr>
</table><br><br>

<!---------------------------------------------------------------->

<table width="100%">
<tr>
<td width="50%">

```ml
{{fun {a} {- a 8}} -3}
```

</td>
<td>

```txt
--------------------------
   y  |         0         
--------------------------
   x  |         0         
--------------------------
 foo  | {fun {a} {- a 8}} 
--------------------------
  y   |         8         
--------------------------
  x   |         4         
--------------------------
```
</td>
</tr>
</table><br><br>

<table width="100%">
<tr>
<td width="50%">

```ml
{- -3 8}
```

</td>
<td>

```txt
--------------------------
   y  |         0         
--------------------------
   x  |         0         
--------------------------
 foo  | {fun {a} {- a 8}} 
--------------------------
  y   |         8         
--------------------------
  x   |         4         
--------------------------
```
</td>
</tr>
</table><br><br>

<table width="100%">
<tr>
<td width="50%">

```ml
-11
```

</td>
<td>

```txt
--------------------------
   y  |         0         
--------------------------
   x  |         0         
--------------------------
 foo  | {fun {a} {- a 8}} 
--------------------------
  y   |         8         
--------------------------
  x   |         4         
--------------------------
```

</td>
</tr>
</table><br><br>



- Evaluación glotona y alcance dinámico.

<br>

```ml
{with {x {+ 2 2}}
    {with {y {+ x x}}
        {with {foo {fun {a} {- a y}}}
            {with {x {- 2 2}}
                {with {y {- x x}}
                    {foo -3}}}}}
```
- Evaluación glotona y alcance estático.

Solucion:

```ml
{with {y {+ x x}}
    {with {foo {fun {a} {- a y}}}
        {with {x {- 2 2}}
            {with {y {- x x}}
                {foo -3}}}}
```

```txt
---------
 x  |  4
---------
```

<br><br>
- Evaluación perezosa y alcance estático.
- Evaluación perezosa y alcance dinámico.
