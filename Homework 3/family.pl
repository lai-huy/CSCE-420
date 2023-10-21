% For constants, use the black bold text in the family tree (first line).

% males
male(charles).
male(william).
male(harry).
male(george).
male(louis).
male(archie).

% females
female(diana).
female(camila).
female(catherine).
female(meghan).
female(charlotte).
female(lilibet).

% spouse
spouse(charles, diana).
spouse(diana, charles).
spouse(charles, camila).
spouse(camila, charles).
spouse(william, catherine).
spouse(catherine, william).
spouse(harry, meghan).
spouse(meghan, harry).

% parent(X, Y) : X is a parent of Y.
parent(charles, william).
parent(charles, harry).
parent(diana, william).
parent(diana, harry).
parent(william, george).
parent(william, charlotte).
parent(william, louis).
parent(catherine, george).
parent(catherine, charlotte).
parent(catherine, louis).
parent(harry, archie).
parent(harry, lilibet).
parent(meghan, archie).
parent(meghan, lilibet).

% In all predicates below, relation(X,Y) means X is a "relation" of Y.
% For example, child(X,Y) = X is a child of Y.
%
% In some of the rules, you may need X != Y (X is not the same as Y).
% - As you go along, use rules defined above it as much as possible.
%
% NOTE: in prolog, variables are uppercase: X, Y, Z, ...
% constants are lowercase: charles, diana, ...

father(X, Y) :- male(X), parent(X, Y).
mother(X, Y) :- female(X), parent(X, Y).

% brother(X, Y) means X is a brother of Y.
brother(X, Y) :-
    male(X),
    parent(Z, X),   % X shares at least one parent with Y
    parent(Z, Y),
    X \= Y.         % X is not the same as Y

% sister(X, Y) means X is a sister of Y.
sister(X, Y) :-
    female(X),
    parent(Z, X),   % X shares at least one parent with Y
    parent(Z, Y),
    X \= Y.         % X is not the same as Y

% Sibling(X, Y) means X is a sibling of Y.
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.  % X is not the same as Y

% Nephew(X, Y) means X is a nephew of Y.
nephew(X, Y) :-
    male(X),
    parent(Z, X),   % Xs parent is a sibling of Y
    sibling(Z, Y).

% Niece(X, Y) means X is a niece of Y.
niece(X, Y) :-
    female(X),
    parent(Z, X),   % X parent is a sibling of Y
    sibling(Z, Y).

% grandparent(X, Y) means X is a grandparent of Y.
grandparent(X, Y) :-
    parent(X, Z),   % X is a parent of Z
    parent(Z, Y).   % Z is a parent of Y

% stepmother(X, Y) means X is a stepmother of Y.
stepmother(X, Y) :-
    female(X),          % X is a female
    parent(Z, Y),       % Z is a parent of Y
    \+ parent(X, Y),    % X is not a parent of Y (to exclude biological parents)
    spouse(X, W),       % X is a spouse of W
    parent(W, Y),       % W is a parent of Y
    Z \= Y,             % Z is not the same as Y
    Z \= W.             % Z is not the same as W

% cousin(X, Y) means X is a cousin of Y.
cousin(X, Y) :-
    parent(Z, X),   % Z is a parent of X
    parent(W, Y),   % W is a parent of Y
    sibling(Z, W),  % Z and W are siblings
    X \= Y.         % X is not the same as Y

% uncle(X, Y) means X is an uncle of Y.
uncle(X, Y) :-
    male(X),
    parent(Z, Y),   % Z is a parent of Y
    (sibling(X, Z); % X is a sibling of Z
    (sibling(S, Z),
    spouse(X, S))). % OR X is the spouse of a sibling of Z


% aunt(X, Y) means X is an aunt of Y.
aunt(X, Y) :-
    female(X),
    parent(Z, Y),   % Z is a parent of Y
    (sibling(X, Z); % X is a sibling of Z
    (sibling(S, Z),
    spouse(X, S))). % OR X is the spouse of a sibling of Z
