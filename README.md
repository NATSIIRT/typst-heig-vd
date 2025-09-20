A mettre dans home > natsirt > .local > share > typst > packages > local > heig-vd-summary > 1.0.0 > lib.typ

On windows : 

```bash
winget install --id Typst.Typst
```

And then add the files in the following path : `C:\Users\titan\AppData\Local\typst\packages\preview\heig-vd\1.0.0`.

To import : 

```
#import "@preview/heig-vd:1.0.0": project;

@show: project.with(...)
```
