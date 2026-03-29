texture(Texture, Env) :-
	(
		member(Texture, [scales, leather]);
		(Texture == feathers, Env \= sea)
	) -> true;
	throw(error(
		invalid_texture(Texture, Env),
		context(texture/2, "Texture not valid for this Environment.")
	)).
wings(Count, Env) :-
	(
		(Count == 0, Env == land);
		(Env \= land, member(Count, [0, 2]))
	) -> true;
	throw(error(
		invalid_wing_count(Count, Env),
		context(wings/2, "Wing count not valid for this Environment.")
	)).
colour(C) :- member(C, [red, orange, yellow, green, blue, purple, pink, brown, black, white, gold, silver, bronze]).
colours(Primary, Secondary, Accent) :-
	(
		maplist(colour, [Primary, Secondary, Accent]),
		(
			\+ member(Primary, [Secondary, Accent]),
			Secondary \= Accent
		)
	) -> true;
	throw(error(
		invalid_colours(Primary, Secondary, Accent),
		context(colours/3, "Invalid Colours.")
	)).
validate(E, T, W_c, C_p, C_s, C_a) :-
	catch(
		(
			texture(T, E),
			wings(W_c, E),
			colours(C_p, C_s, C_a)
		),
		error(Reason, context(_, Msg)),
		format("Validation failed: ~w - ~w~n", [Reason, Msg])
	).
