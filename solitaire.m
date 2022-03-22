counter = 0;
for a = 1:1*10^8
    [counter] = run(counter);
end
stopped = a-counter;
porcentage = stopped/a*100;
disp(porcentage)

function [counter] = run(counter)
% hard 8
% easy 24
length_deck = 24;
cards_deck = zeros(1,length_deck);
cards_up = zeros(1,7);
used = zeros(1,7+length_deck);

% collect the cards to be used, (not repeated)
for i = 1:7+length_deck
    r = randi([1,52],1,1);
    while ismember(r,used)
        r = randi([1,52],1,1);
    end
    used(i) = r;
end

% make arrays with the cards
% cards turned up / cards in deck
for i = 1:length_deck
    cards_deck(i) = used(i);
end
for i = 1:7
    cards_up(i) = used(i+length_deck);
end

%  check for aces
for i = 1:7+length_deck
    if used(i) == 13 || used(i) == 26 || used(i) == 39 || used(i) == 52
        counter = counter + 1;
        return
    end
end

% save the colors for the cards turned up
colors = strings(1,7);
for i = 1:7
    if cards_up(i) > 26
        colors(i) = "r"; % red
    else
        colors(i) = "n"; % black
    end
end

for i = 1:length_deck
    
    card = cards_deck(i); % card to be compared
    card_rem = rem(card,13); % the card (independently from the color)
    
    % check the color of the card
    if card > 26
        color = "r"; % red
    else
        color = "n"; % black
    end
    
    % check if the card is a King
    % doesn't connect if it is a King
    if card_rem ~= 1
        for ii = 1:7
            % check if the colors mismatch
            if color ~= colors(ii)
                % check if it can be joined
                for u = 1:4
                    if card_rem-1+(u-1)*13 == cards_up(ii)
                        counter = counter + 1;
                        return
                    end
                end
            end
        end
    end
end
% function to print the permutation that can't be connected
%show(cards_up,cards_deck)
end

function show(cards_up,cards_deck)
% array that shows the way the cards are organized
cards = ["KB1","QB1","JB1","10B1","9B1","8B1","7B1","6B1","5B1","4B1","3B1","2B1","AB1",...
          "KB2","QB2","JB2","10B2","9B2","8B2","7B2","6B2","5B2","4B2","3B2","2B2","AB2",...
          "KW1","QW1","JW1","10W1","9W1","8W1","7W1","6W1","5W1","4W1","3W1","2W1","AW1",...
          "KW2","QW2","JW2","10W2","9W2","8W2","7W2","6W2","5W2","4W2","3W2","2W2","AW2"];
cards_u_s = strings(1,length(cards_up));
cards_d_s = strings(1,length(cards_deck));
for i = 1:length(cards_up)
    cards_u_s(i) = cards(cards_up(i));
end
for i = 1:length(cards_deck)
    cards_d_s(i) = cards(cards_deck(i));
end
disp(cards_d_s)
disp(cards_u_s)
end