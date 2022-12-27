# Code Suggestion & Generation

### Suggestion
E.g. searching StackOverflow for answers. see [here](https://github.com/hieunc229/copilot-clone/).


### Generation


---
## Installation

```
python3 -m pip install venv
python3 -m venv venv
. venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install -e .
```

---
## Testing

```
babble

```

---
## NOTES
### Workaround for Tensorflow error ""
```
you may be able to use the workaround posted by another user. Create a symbolic link to the (incorrect) version library, and if you’re on WSL2 Linux like me, add or export the LD_LIBRARY_PATH. I did this:

(kohya) nano@DESKTOP-73RPGPM:~/kohya_ss$ find / -name libnvinfer.so.8
/home/nano/anaconda3/envs/kohya/lib/python3.10/site-packages/tensorrt/libnvinfer.so.8

sudo ln -s /home/nano/anaconda3/envs/kohya/lib/python3.10/site-packages/tensorrt/libnvinfer.so.8 /home/nano/anaconda3/envs/kohya/lib/python3.10/site-packages/tensorrt/libnvinfer.so.7
sudo ln -s /home/nano/anaconda3/envs/kohya/lib/python3.10/site-packages/tensorrt/libnvinfer_plugin.so.8 /home/nano/anaconda3/envs/kohya/lib/python3.10/site-packages/tensorrt/libnvinfer_plugin.so.7
libnvinfer_plugin.so.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/nano/anaconda3/envs/kohya/lib/python3.10/site-packages/tensorrt/

Thanks to xxy1836 for the workaround.
```


---
## Links
  - https://www.kdnuggets.com/2021/07/github-copilot-open-source-alternatives-code-generation.html
  - https://github.com/samrawal/emacs-secondmate/

