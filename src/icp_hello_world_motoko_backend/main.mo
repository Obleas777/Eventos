import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Text "mo:base/Text";

actor Main {
    type Event = {
        id: Text;
        name: Text;
        sport: Text;
        date: Text;
        location: Text;
    };

    var events: HashMap.HashMap<Text, Event> = HashMap.HashMap<Text, Event>(10, Text.equal, Text.hash);

    public func createEvent(id: Text, name: Text, sport: Text, date: Text, location: Text): async Event {
        let newEvent = {
            id = id;
            name = name;
            sport = sport;
            date = date;
            location = location;
        };
        events.put(id, newEvent);
        return newEvent;
    };

    public query func getAllEvents(): async [Event] {
        return Iter.toArray<Event>(Iter.map<(Text, Event), Event>(events.entries(), func ((_, event)) { event }));
    };

    public func deleteEvent(id: Text): async Bool {
        if (Option.isSome(events.get(id))) {
            ignore events.remove(id);
            return true;
        } else {
            return false;
        };
    };

    public query func getEventById(id: Text): async ?Event {
        return events.get(id);
    };

    public query func searchEventsByName(name: Text): async [Event] {
        return Iter.toArray<Event>(Iter.filter<Event>(Iter.map<(Text, Event), Event>(events.entries(), func ((_, event)) { event }), func (event) { event.name == name }));
    };

    public query func searchEventsBySport(sport: Text): async [Event] {
        return Iter.toArray<Event>(Iter.filter<Event>(Iter.map<(Text, Event), Event>(events.entries(), func ((_, event)) { event }), func (event) { event.sport == sport }));
    };
};
