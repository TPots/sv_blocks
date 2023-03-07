import re
import os
from glob import glob

def makedoc( file_ext: str ) -> None:
    """Read through the subdirectories located in the current directory.
    For each file with a matching extention to the argument `file_ext`, match any text
    found between `////` strings and write the match into a README.adoc file.

    Args:
        file_ext (str): a file extention to look for.
    """    
    
    path = os.getcwd()
    subdir = [ d for d in os.listdir() if os.path.isdir(d) ]

    for directory in subdir:
        dir_files = glob(f'*.{file_ext}',root_dir=os.path.join(path,directory))
    
        if len(dir_files) != 0:
            with open(f'{os.path.join(path, directory, "README.adoc")}', 'w') as readme:
                for f in dir_files:
                    with open(f'{os.path.join(path,directory,f)}', 'r') as dir_file:
                        stub = dir_file.read()
                        doc_string = re.search(r"(?<=/{4}\n)(.*?)(?=/{4}\n)",stub,re.DOTALL)
                        if doc_string is not None:
                            readme.write(doc_string.group(0))
                            readme.write('\n')
                        else:
                            pass
        else:
            pass
    return

def main():
    makedoc( 'sv' )
    return    

if __name__ == '__main__':
    main()