# Lenguajes de Programación - Tarea 4

## Integrantes 
---

<br>

| **Nombre** | **No. de cuenta** |
|---|---|
| *Cureño Sánchez Misael* | 418002485 |
| *González Mancera Ivette* | 316014490 |

<br>

## Instrucciones
---
Resolver los siguientes ejercicios de forma clara y ordenada de acuerdo a los lineamientos de entrega de tareas disponibles en la página del curso.


<br>

## Ejercicios
---

<br>

1. Currifica cada uno de los siguientes términos.

    -  $\lambda xyz . xyz$

        $= \lambda x.\lambda y. \lambda z . xyz$

    <br>
    
    - $\lambda uvw. \lambda wxy.uwvxwy$
    
        $= \lambda u.\lambda v. \lambda w. \lambda w. \lambda x \lambda y.uwvxwy$
        
    <br>
    
    - $\lambda x.((\lambda xy.y)(\lambda zw.w))(\lambda uv.v)$

        $= \lambda x.((\lambda x.\lambda y.y)(\lambda z. \lambda w.w))(\lambda u. \lambda v.v)$
    <br>
    
2. Aplica $\alpha$-conversiones en cada expresión para cambiar los términos de las variables de ligado.

    <br>

    - $\lambda u. \lambda v.((\lambda u.v) (\lambda v.u))$

        $= \lambda a.\lambda b.((\lambda u.b)(\lambda v.a))$

    <br>

    - $\lambda u.(u(\lambda v.((\lambda u.u) v)u))$

        $= \lambda c.(c(\lambda d.((\lambda u.u) d) c))$
    
    <br>

    - $\lambda x.((\lambda y.x) \lambda y.(\lambda x.x y))$

        $= \lambda e.((\lambda y.e) \lambda f.(\lambda x.x f))$

    <br>

3. Aplica $\beta$-reducciones a las siguientes expresiones para llegar a una **forma normal**, en caso de que no se pueda justifica. Además indica en cada paso el *reducto* y el *redex*.

    <br>
    <center>

    $$I =_{def} \lambda a.a$$

    $$K =_{def} \lambda a. \lambda b.a$$

    $$\Omega =_{def} (\lambda a.aa) (\lambda a.aa)$$
    
    </center>
    <br><br>

    - $\lambda a.((aK)\Omega)$

        $ = \quad \lambda a.((a(\lambda a. \lambda b.a))(\lambda a.aa) (\lambda a.aa))$ <br>
        $ \rightarrow_\beta \lambda a.((a(\lambda a. \lambda b.a))(\lambda a.aa) (\lambda a.aa))$

        No se puede llegar a una forma normal, dado que el
        la única $\beta$-reducción que podríamos llevar a cabo es la evaluacion
        de $K$ en a, pero desconocemos el valor de $a$, además si intentamos beta-reducir a $\Omega$, nos encontraremos por lo visto en clase que no cuenta con una forma normal.
    
    <br><br>

    - $(\lambda a.a(II))c$

        $ = \quad (\lambda a.a((\lambda a.a)(\lambda a.a)))c$ <br>
        $\rightarrow_\beta c((\lambda a.a)(\lambda a.a))$ <br>
        $\rightarrow_\beta c(\lambda a.a)$ <br>

        Como se puede aplicar la beta reducción directamente sin aplicar la alpha equivalencia, los <b>*redex*</b> correspondientes son , para cada renglon respectivamente la primera $(\lambda a.a)$ de cada uno, mientras que los <b>*reductos*</b> son el resultado de aplicar la beta-reduccion.

    <br>

    - $(\lambda d. \lambda e.(\lambda f.f(\lambda a.ad))e)b(\lambda c. \lambda b.cb)$
    
        $ \rightarrow_\beta (\lambda e.(\lambda f.f(\lambda a.ab))e)(\lambda c. \lambda b.cb)$ <br>
        $\rightarrow_\beta (\lambda f.f(\lambda a.ab))(\lambda c. \lambda b.cb)$ <br>
        $\rightarrow_\beta (\lambda c. \lambda b.cb)(\lambda a.ab)$ <br>
        $\rightarrow_\beta \lambda b.(\lambda a.ac)b$ <br>

        **Redex**:

        - $(\lambda d. \lambda e.(\lambda f.f(\lambda a.ad))e)$
        - $(\lambda e.(\lambda f.f(\lambda a.ab))e)$
        - $(\lambda f.f(\lambda a.ab))$
        - $(\lambda c. \lambda b.cb)$
        - Ninguno, pues se aplicó una alpha equivalencia para hacer la sustitucion apropiadamente.
    
    <br>


<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({ tex2jax: {inlineMath: [['$', '$']]}, messageStyle: "none" });
</script>