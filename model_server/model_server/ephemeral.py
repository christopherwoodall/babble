
from threading import Thread


from . import server


def input_loop():
  while (user_input := input("QUERY: ")) != 'q':
    print(f'You typed: {user_input}')
    generation = server.autocomplete(user_input)
    print(f'Generation: {generation}')


def main():
  print('Hello world!')
  input_thread = Thread(target=input_loop, args=())
  input_thread.start()
  server.serve()
  input_thread.join()


if __name__ == '__main__':
  main()
