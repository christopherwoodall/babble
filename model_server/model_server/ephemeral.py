
from threading import Thread


from . import server


def input_loop():
  while (in := input()) != 'q':
    print(f'You typed: {in}')
    # TODO: Send to server


def main():
  print('Hello, ephemeral world!')
  input_thread = Thread(target=input_loop, args=())
  input_thread.start()
  server.serve()
  input_thread.join()



if __name__ == '__main__':
  main()
