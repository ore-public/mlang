typedef struct MNode {
	union {
		struct MNode *node;
	} u1;

	union {
		struct MNode *node;
	} u2;

	union {
		struct MNode *node;
	} u3;
} NODE;
