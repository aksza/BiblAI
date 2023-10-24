import {useQuery} from 'react-query'
import Axios from 'axios';
import { useState } from 'react';
import { Post } from '../components/Post';




interface Posts {
  userName: string;
  posts: Ppost[];
}

export interface Ppost {
  question: string;
  answer: string;
  anonym: boolean;
  user: Uuser;
}

export interface Uuser {
  id: number;
  userName: string;
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  birthDate: string;
  gender: boolean;
  married: boolean;
  bios: string;
  religion: string;
  posts: null;
}

interface PostProps {
  post: Ppost;
}

export const Home = () => {
  const [posts, setPosts] = useState<Posts>({} as Posts);

  const { data, isLoading, isError, refetch } = useQuery(['posts'], () => {
    return Axios.get(`https://localhost:7060/api/Post`)
      .then((res) => {
        console.log(res.data);
        setPosts(res.data);
      });
  });



  return (
    <div className="Home">
      {isLoading && <div>Loading...</div>}
      {isError && <div>Error fetching data</div>}
      <div>
        {posts.posts?.map((post: Ppost) => (
          <Post key={post.question} post={post} />
        ))}
      </div>
      
    </div>
  );
}