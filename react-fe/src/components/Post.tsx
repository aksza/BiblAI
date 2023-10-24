import {Ppost, Uuser} from '../pages/Home'
import {Link} from 'react-router-dom';
import '../styles/post_card.css'

interface PostProps {
  post: Ppost;
}

interface UserProps {
  user: Uuser;
}


export const Post: React.FC<PostProps> = ({ post }) => {
  return (
    <div className="Post">
      <div className="question_area">
        <p>{[post.question]}</p>
      </div>
      <div className="profile_info_area">
        <p>{post.user.userName}</p>
        <Link to="/profile"><img src="https://cdn-icons-png.flaticon.com/128/3917/3917711.png" alt="" /></Link>
      </div>
      <div className="answer_area">
        <p>{[post.answer]}</p>
      </div>
      <div className="feedback_area">
        <p>1</p>
        <img src="https://cdn-icons-png.flaticon.com/128/3916/3916818.png" alt="" />
        <p>1</p>
        <img src="https://cdn-icons-png.flaticon.com/128/3916/3916823.png" alt="" />
        <p>0</p>
        <img src="https://cdn-icons-png.flaticon.com/128/3916/3916599.png" alt="" />
      </div>
    </div>
  );
}