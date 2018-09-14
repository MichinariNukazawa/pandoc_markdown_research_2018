# Sample Codes
highlight-style: HIGHLIGHT_STYLE_KIND  

## HTML
```html
<label for='editor__fragment-is_auto_size'>
	<input id='editor__fragment-is_auto_size' class='foo,bar,loooooooooooooooooooooooongclass' type="checkbox"/>
	<span>AutoSize</span>
</label>
<span>span</span>
```
## CSS
```css
input[type="number"]{
	font-family: Consolas, 'Courier New', Courier, Monaco, monospace;
	line-height: 130%;
}
input[type="checkbox"][disabled] + span{
	color: #707070;
}

.frame{
	border: solid 1px rgba(0, 0, 0, 0.5);
}
#frameone{
	border-radius: 2px;
}
```
## JavaScript
```js
'use strict';
var remote = require('remote')

export default class Esperanto{
	/** @brief x-systemo */
	static convert_caret_from_x_sistemo(str)
	{
		const replaces = [
			[/u\~/g, "\u016D"],
		];
		for(const replace of replaces){
			str = str.replace(replace[0], replace[1]);
		}
		return str;
	}
}
function command(keyword){
	// 日本語コメントながーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーい
	if(a){if(b){call_of_looooooooooooooooooooooongfunction("space only in string literal to loooooooooooooooooong");}}
	return ":help " + "looooooooooooooooooooooooong string" + Language.get_command_list().join(" ");
}
```
---
