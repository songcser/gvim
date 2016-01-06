#技巧20
* 很多普通模式命令，在可视模式中也完成相同的功能
* 在可视模式中，先选中选区，然后再触发修改命令

#技巧21
```
v					#激活面向字符的可视模式
V					#激活面向行的可视模式
<C-v>				#激活面向列块的可视模式
gv					#重选上次的高亮选区
o					#切换高亮选区的活动端
```
#技巧22
使用 . 命令重复对高亮选区所做的修改时，此修改会重复作用于相同范围的文本

#技巧23
只要可能，最好用操作符命令，而不是可视命令
> 可视模式可能比Vim的普通模式操作起来更自然一些，但是它有一个缺点：在这个模式下 . 命令有时会有一些异常的表现。我们可以用普通模式下的操作符命令来规避此缺点

```
vitU      			#选中文本，转换成大写
gUit				#一个操作符(gU)和一个动作命令(it)
```
使用点重复某些有用工作时，使用操作符命令更好

#技巧24
使用面向列块的可视模式编辑表格数据

在Vim列块可视模式中，修改命令的表现或许有点怪，它看上去有点