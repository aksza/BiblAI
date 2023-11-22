import {Uuser} from '../pages/Home'
import Axios from 'axios';
import { useState } from 'react';
import { useQuery } from "react-query"
import '../styles/profile_page.css'
import { useParams } from 'react-router-dom';
import { Users, Ppost } from '../pages/Home';
import { Post } from '../components/Post';



export const Profile = () => {
  const [user, setUser] = useState<Users>({} as Users);
  const { userId } = useParams();

  const { data, isLoading, isError, refetch } = useQuery(['user'], () => {
    return Axios.get(`http://localhost:7060/profile/${userId}`)
      .then((res) => {
        console.log(res.data);
        setUser(res.data);
      });
  });


  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (isError) {
    return <div>Error loading user data.</div>;
  }

  return (
    <div className="Profile">
      <div className="user_info">
        <div className="bios_part">
          <img src={user.userInfo.profilePictureUrl} alt="blank" /> 
          <div className="right_bios_part">
            <p><b>@{user.userInfo.userName}</b> {user.userInfo.firstName} {user.userInfo.lastName}</p>
            <p>{user.userInfo.bio}</p>
          </div>
        </div>
        <div className="buttons">
          <button>My posts</button>
          <button>My answers</button>
          <button>Liked posts</button>
        </div>
        
      </div>
      <div className="user_posts">
        {user.posts?.map((post: Ppost) => (
          <Post key={post.question} post={post} />
        ))}
      </div>
    </div>
  );
}