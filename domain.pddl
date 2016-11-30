;;; Artificial Intelligence course, Professor Tsz-Chiu Au ;;;
;; Programming assignment 5: Planning Domain Definition Language ;;;
;;; Aibek Smagulov 20142028 smagulovaybek@gmail.com ;;;

(define (domain pyramid-domain)
    (:requirements :adl :typing :derived-predicates)
    (:types NUMBER CARD)
    (:predicates 
        (sum-equal-13 ?x ?y - NUMBER)
        (covers ?x ?y - CARD)
        (deck ?x - CARD)
        (pyramid ?x - CARD)
        (waste ?x - CARD)
        (matched ?x - CARD)
        (value ?c - CARD ?n - NUMBER) 
        (cycle1)
        (cycle2)
        (cycle3)

        (card-equal-13 ?x - CARD ?y - CARD) 
        (covered ?c - CARD)
    )

    (:derived (card-equal-13 ?x - CARD ?y - CARD) 
        (exists (?val1 - NUMBER)
            (exists (?val2 - NUMBER)
                (and
                    (value ?x ?val1)
                    (value ?y ?val2)
                    (sum-equal-13 ?val1 ?val2)
                )
            )
        )
    )

    (:derived (covered ?c - CARD) 
        (exists (?x - CARD)
            (covers ?x ?c)
        )
    )
    
    (:action match
        :parameters (?x - CARD ?y - CARD)
        :precondition (and
            (not (covered ?x))
            (not (covered ?y))
            (card-equal-13 ?x ?y)
            ;;;;;;; (not (= ?x ?y))
            (or (and (pyramid ?x) (pyramid ?y))
                (and (pyramid ?x) (deck ?y))
                (and (deck ?x) (pyramid ?y))
                (and (pyramid ?x) (waste ?y))
                (and (waste ?x) (pyramid ?y))
                (and (deck ?x) (waste ?y))
                (and (waste ?x) (deck ?y))
            )
        )
        :effect (and
            (matched ?x)
            (matched ?y)
            (forall (?cx - CARD) (when (covers ?x ?cx) (not (covers ?x ?cx))))
            (forall (?cy - CARD) (when (covers ?y ?cy) (not (covers ?y ?cy))))
            (when (deck ?x) (not (deck ?x)))
            (when (pyramid ?x) (not (pyramid ?x)))
            (when (waste ?x) (not (waste ?x)))
            (when (deck ?y) (not (deck ?y)))
            (when (pyramid ?y) (not (pyramid ?y)))
            (when (waste ?y) (not (waste ?y)))
        )
    )

    (:action king-match
        :parameters (?x - CARD)
        :precondition (and
            (value ?x n13)
            (not (covered ?x))
        )
        :effect (and
            (matched ?x)
            (when (deck ?x) (not (deck ?x)))
            (when (pyramid ?x) (not (pyramid ?x)))
            (when (waste ?x) (not (waste ?x)))
            (forall (?y - CARD)
                (when (covers ?x ?y) (not (covers ?x ?y)))
            )
        )
    )

    (:action draw
        :parameters (?x - CARD)
        :precondition (and
            (deck ?x)
            (not (covered ?x))
        )
        :effect (and
            (forall (?y - CARD) (when (covers ?x ?y) (not (covers ?x ?y))))
            (not (deck ?x))
            (forall (?y - CARD) (when 
                (and
                    (waste ?y)
                    (not (covered ?y))
                )
                (covers ?x ?y)
            ))
            (waste ?x)
        )
    )

    (:action cycle
        :parameters ()
        :precondition (and
            (not (exists (?x - CARD) (deck ?x)))
            (exists (?x - CARD) (waste ?x))
            (not (cycle3))
        )
        :effect (and
            (forall (?x - CARD ?y - CARD)
                (when 
                    (and
                        (waste ?y)
                        (covers ?x ?y)
                    )
                    (and
                        (covers ?y ?x)
                        (not (covers ?x ?y))
                        (not (waste ?x))
                        (not (waste ?))
                        (deck ?x)
                        (deck ?y)
                    )
                )
            )
            (when (and (cycle2) (not (cycle3))) (cycle3))
            (when (and (cycle1) (not (cycle2))) (cycle2))
            (when (not (cycle1)) (cycle1))
        )
    )
)
