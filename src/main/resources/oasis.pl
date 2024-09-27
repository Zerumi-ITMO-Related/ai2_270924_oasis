% Knowledge base for Ready Player One
% Ready Player One is the book written by Ernest Cline that is the basis for the movie of the same name
% The plot describes a dystopian future where people escape their reality by entering a virtual reality world 
% called the OASIS. The creator of the OASIS, James Halliday, has hidden an Easter egg in the OASIS and the
% first person to find it will inherit his fortune. The protagonist, Wade Watts, is a teenager who is obsessed
% with finding the Easter egg and winning the contest. The antagonist, Nolan Sorrento, is the CEO of a company IOI
% that wants to find the Easter egg to take control of the OASIS and monetize it. The book is filled with 80s
% pop culture references and the protagonist has to solve puzzles and challenges that are based on 80s trivia.

%%% Facts

% The following are the facts about the characters in the book
% The protagonist of the book is Wade Watts
character(parzival).
% The "High Five" is the group of friends that Wade Watts teams up with to find the Easter egg
character(art3mis).
character(aech).
character(daito).
character(shoto).
% The antagonist of the book is Nolan Sorrento
character(nolan_sorrento).
% The creator of the OASIS is James Halliday
character(james_halliday).
% Morrow is the co-creator of the OASIS
character(morrow).
% Nag1bat0r is the classmate of Wade Watts
character(nag1bat0r).

% The plot of the book takes place in a dystopian future, an MMORPG called the OASIS
reality(oasis).

% OASIS contains millions of planets and is a virtual reality world where people can escape their reality
% Here we define some of this locations, connected to the plot
% Planet Ludus is the planet where the protagonist, Wade Watts, goes to school. And where the first key is hidden
planet(ludus).
% On planet Middletowb the first gate is located
planet(middletown).
% Planet Archaide is the planet where Parzival finds the artifact that gives him extra life
planet(archaide).
% Planet Frobozz is the planet where the protagonist, Wade Watts, finds the second key
planet(frobozz).
% Planet Axrenox is the planet where Parzival accessed the second gate
planet(axrenox).
% The planet where the final key hidden
planet(planet_doom).
% The Chthonia is the planet where the final battle takes place
planet(chthonia).

% Keys should open gates
gate(first_gate).
gate(second_gate).
gate(third_gate).

% The following are the facts about the key items in the book
% The first item is the Copper Key
item(copper_key).
% The second item is the Jade Key
item(jade_key).
% The third item is the Crystal Key
item(crystal_key).
% The final item of the challenge is the Easter egg
item(easter_egg).
% The artifact that gives character an extra life
item(extra_life).

% Describe companies and organizations in the book
% IOI is the company that wants to find the Easter egg to take control of the OASIS
organization(ioi).
% GSS is the company that created the OASIS
organization(gss).
% The High Five is the group of friends that Wade Watts teams up with to find the Easter egg
organization(high_five).

% The following are the facts about the relationships between the characters, locations, and items in the book
% Wade Watts, Art3mis, Aech, Daito, and Shoto are the members of the High Five
organization_member(parzival, high_five).
organization_member(art3mis, high_five).
organization_member(aech, high_five).
organization_member(daito, high_five).
organization_member(shoto, high_five).
% Morrow and James Halliday are the creators of the OASIS and founders of GCC company
founder(morrow, gss).
founder(james_halliday, gss).
% Sorrento is the CEO of IOI
ceo(nolan_sorrento, ioi).

% The Copper Key is hidden on the planet Ludus
location(copper_key, ludus).
% The Jade Key is hidden on the planet Frobozz
location(jade_key, frobozz).
% The Crystal Key is hidden on the planet Doom
location(crystal_key, planet_doom).

% The first gate is located on the planet Middletown
location(first_gate, middletown).
% The second gate is located on the planet Axrenox
location(second_gate, axrenox).
% The final gate is located on the planet Chthonia
location(third_gate, chthonia).

% The artifact that gives Parzival an extra life is located on the planet Archaide
location(extra_life, archaide).

% The extra life artifact belongs to the Parzival
belongs_to(extra_life, parzival).

% High Five have all of the keys, expect Daito, who were killed by IOI
has_key(parzival, copper_key).
has_key(parzival, jade_key).
has_key(parzival, crystal_key).
has_key(art3mis, copper_key).
has_key(art3mis, jade_key).
has_key(art3mis, crystal_key).
has_key(aech, copper_key).
has_key(aech, jade_key).
has_key(aech, crystal_key).
has_key(daito, copper_key).
has_key(daito, jade_key).
has_key(shoto, copper_key).
has_key(shoto, jade_key).
has_key(shoto, crystal_key).

% IOI CEO have all of the keys
has_key(nolan_sorrento, copper_key).
has_key(nolan_sorrento, jade_key).
has_key(nolan_sorrento, crystal_key).

% The final battle takes place on the planet Chthonia. The High Five and IOI fight for the Easter egg
charachter_location(parzival, chthonia).
charachter_location(art3mis, chthonia).
charachter_location(aech, chthonia).
charachter_location(shoto, chthonia).
charachter_location(nolan_sorrento, chthonia).

%%% Rules

% This rule checks if a character is a member of organization
is_member_of(X, Y) :- organization(Y), (organization_member(X, Y); founder(X, Y); ceo(X, Y)).

% This rule checks if a character is a member of the High Five
is_high_five(X) :- character(X), organization_member(X, high_five).

% This rule checks if a character has an extra life
has_extra_life(X) :- belongs_to(extra_life, X).

% This rule checks if a character participates in the final battle
participates_in_final_battle(X) :- character(X), charachter_location(X, chthonia), has_all_keys(X).

% This rule checks if a character has all the keys
has_all_keys(X) :- has_key(X, copper_key), has_key(X, jade_key), has_key(X, crystal_key).

%%% Knowledge Base Request Examples
% Get all the characters in the book
% ?- character(X).
% Get all key holders
% ?- has_key(X, <key>).
% Get information about holding all keys of character
% ?- has_all_keys(X).
% Get all the members of the High Five
% ?- is_high_five(X).
% Get all the members of the High Five, who have an extra life
% ?- is_high_five(X), has_extra_life(X).
% Get characters, who don't belong to any organization
% ?- character(X), \+ is_member_of(X, _).
