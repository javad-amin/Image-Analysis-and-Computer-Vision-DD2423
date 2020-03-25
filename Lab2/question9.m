function question9()
  ht = houghtest256;

  figure(2)
  houghedgeline(ht, 1, 5, 20, 180, 10);

  figure(3)
  [height width] = size(ht);
  nrho = ceil(norm([height, width]));
  houghedgeline(ht, 1, 5, nrho, 4, 10);
end
