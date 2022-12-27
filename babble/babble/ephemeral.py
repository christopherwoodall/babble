
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
  input_loop()
  # input_thread = Thread(target=input_loop, args=())
  # input_thread.start()
  # server.serve()
  # input_thread.join()



if __name__ == '__main__':
  main()
