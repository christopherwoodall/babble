import sys
import http
import urllib

from threading import Thread

from babble import model
from babble import server


class EphemeralAction:
    def __init__(self):
        ...


def input_loop():
    while (user_input := input("QUERY: ")) != "q":
        print(f"You typed: {user_input}")
        try:
            user_input = urllib.parse.urlencode({"text": user_input})
            # generation = model.autocomplete(user_input)
            generation = http.client.HTTPConnection("127.0.0.1", 9000)
            generation.request("GET", "/", user_input)
            generation = generation.getresponse().read()
        except Exception as e:
            print(f"Error: {e}")
            generation = "FAILED"
        print(f"Generation: {generation}")
    return sys.exit()


def main():
    # action = EphemeralAction()
    server.serve(9000)
    # server_thread = Thread(target=server.serve, args=(9000,), daemon=True)
    # input_thread = Thread(target=input_loop, args=())
    # server_thread.start()
    # input_thread.start()
    # server_thread.join()
    # server_thread.join()


if __name__ == "__main__":
    main()
