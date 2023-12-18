import Axios from 'axios';
import { useState } from 'react';
import { useQuery } from "react-query"
import { Link, useParams } from 'react-router-dom';
import { Post } from '../components/Post';
import '../styles/profile_page.css'

import { Users } from '../../models/UserModel'
import { Post as PostType } from '../../models/PostModel'
import { getProfile } from '../services/endpointFetching';


export const Profile = () => {
  const [user, setUser] = useState<Users>({} as Users);
  const { userId } = useParams();

  const { data, isLoading, isError, refetch } = useQuery(['user', userId ?? ''], () => getProfile(userId ?? ''), {
    onSuccess: (data: Users) => {
      setUser(data);
    }
  });

  return (
    
    <div className="Profile">
      {!localStorage.getItem('token') ? <><Link to="/login">Login</Link>to look at others profile</> :
      <div className="user_page">
      <div className="user_info">
        <div className="bios_part">
          <img src={user.profilePictureUrl} alt="blank" /> 
          <div className="right_bios_part">
            <p><b>@{user.userName}</b> {user.firstName} {user.lastName}</p>
            <p>{user.bios}</p>
          </div>
        </div>
        <div className="buttons">
          <button>My posts</button>
          <button>My answers</button>
          <button>Liked posts</button>
        </div>
        
      </div>
      <div className="user_posts">
        {user.posts?.map((post: PostType) => (
          post.anonym ? <Post key={post.question} post = {post} handleLike={() => {}} handleCommentLike={() => {}} handleComment={() => {}} /> : <></>
        ))}
      </div>
    </div>}
    </div>
  );
}