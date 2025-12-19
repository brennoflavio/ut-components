from typing import Dict

from python import setup

setup("example")
import random
from dataclasses import dataclass
from datetime import datetime, timedelta

from python.event import Event, get_event_dispatcher


@dataclass
class FetchTimeResponse:
    time: str


class FetchTime(Event):
    def trigger(self, metadata: None = None) -> object:
        return FetchTimeResponse(time=datetime.now().isoformat())


class RandomNumber(Event):
    def trigger(self, metadata: Dict | None) -> Dict:
        if metadata:
            previous_number = metadata.get("previous", 0)
        else:
            previous_number = 0
        number = random.random()

        get_event_dispatcher().schedule("random-number", {"previous": number}, execution_interval=timedelta(seconds=3))
        return {"number": number, "previous": previous_number}


get_event_dispatcher().register_event(FetchTime(id="fetch-time", execution_interval=timedelta(seconds=5)))
get_event_dispatcher().register_event(RandomNumber(id="random-number"))
get_event_dispatcher().schedule("random-number", {"previous": 0})


def start_loop():
    get_event_dispatcher().start()


def stop_loop():
    get_event_dispatcher().stop()
