
from threading import Thread


from . import server


# def input_loop():
#   while (user_input := input("QUERY: ")) != 'q':
#     print(f'You typed: {user_input}')
#     try:
#       generation = server.autocomplete(user_input)
#     except Exception as e:
#       print(f'Error: {e}')
#       generation = 'FAILED'
#     print(f'Generation: {generation}')
#   return


def main():
  print('Hello world!')
  # input_thread = Thread(target=input_loop, args=())
  # input_thread.start()
  # server.serve()
  # input_thread.join()
  # input_loop()


if __name__ == '__main__':
  main()
