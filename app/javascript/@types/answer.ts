export type Answer = {
  id: number;
  question_id: number;
  content: string;
  good_cnt: number;
  is_best_answer: boolean;
  user_id: number;
  created_at: string;
  replies: Reply[];
};

export type Reply = {
  id: number;
  content: string;
  user_id: number;
};
