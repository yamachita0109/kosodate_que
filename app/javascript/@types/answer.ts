export type Answer = {
  id: string;
  question_id: string;
  content: string;
  good_cnt: number;
  bad_cnt: number;
  is_best_answer: boolean;
  user_id: string;
  user_name: string;
  user_logo: string;
  created_at: string;
  replies: Reply[];
};

export type Reply = {
  id: string;
  content: string;
  user_id: string;
  user_name: string;
  user_logo: string;
  created_at: string;
};
