import {useQuery} from 'react-query'
import Axios from 'axios';
import { useState } from 'react';
import { Post } from '../components/Post';

import { Posts, Post as PostType } from './../../models/PostModel'

import '../styles/home.css'






export const Home = () => {
  const [posts, setPosts] = useState<PostType[]>([] as PostType[]);

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
        {posts.map((post: PostType) => (
          <Post key={post.question} post={post} />
        ))}
      </div>
    </div>
  );
}