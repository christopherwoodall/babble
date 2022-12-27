
from threading import Thread

from . import model
from . import server


class EphemeralAction:
  def __init__(self):
    ...


def input_loop():
  while (user_input := input("QUERY: ")) != 'q':
    print(f'You typed: {user_input}')
    try:
      generation = model.autocomplete(user_input)
    except Exception as e:
      print(f'Error: {e}')
      generation = 'FAILED'
    print(f'Generation: {generation}')
  return


def main():
  # action = EphemeralAction()
  print('Hello world!')
  server_thread = Thread(target=server.serve, args=(9900,))
  input_thread = Thread(target=input_loop, args=())

  server_thread.start()
  input_thread.start()

  server_thread.join()
  server_thread.join()


if __name__ == '__main__':
  main()
