
(easyob-def aaa "echo $BODY" )


(easyob-def aaa "echo $BODY" :head "I am head." :tail "You are tails.")

(easyob-def aaa "echo $BODY"
			:complete-check-regx "main()"
			:complete-prefix "void main(){ "
			:complete-subfix "}")




(easyob-def aaa "echo $BODY" :async t)
